import UIKit

struct ButtonState {
    let context: AnyObject
    let notify: CellButtonStateNotify
    let productId: Int
}

final class CatalogVC<View: CatalogView>: BaseViewController<View> {
    
    init(catalogProvider: CatalogProvider, priceFormatter: NumberFormatter){
        self.catalogProvider = catalogProvider
        self.priceFormatter = priceFormatter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let catalogProvider: CatalogProvider
    let priceFormatter: NumberFormatter
    
    var onDisplayProduct: ((_ id: Int) -> Void)?
    
    var favoriteState: [ButtonState] = []
    
    var productFavoriteCache: [Int: CellButtonState] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        congfigurateNavigationBar()
        
        rootView.onRefresh = { [weak self] in
            self?.loadData(force: true)
        }
        
        rootView.willDisplayProduct = { [weak self] item in
            self?.loadData(offset: item)
        }
        
        loadData()
    }
    
    private func loadData(offset: Int = 0, force: Bool = false) {
        catalogProvider.products(
            offset: offset,
            force: force
        ) { [weak self] result in
            guard let self = self else {
                return
            }
            
            //            rootView.diplayLoadingErrorIndication()...
            
            if let result = result {
                //Успех --> Показываем данные
                self.rootView.display(
                    cellData: makeProducts(products: result),
                    titleData: self.makeTitle(),
                    append: offset != 0,
                    animated: true
                )
            } else {
                //Ошибка --> Показываем какое-то состояние
            }
            
            rootView.displayLoading(enable: false)
            
        }
    }
    
    @objc func toSettings(sender: UIBarButtonItem) {
        //toSettings button action...
    }
}

//MARK: Make data

private extension CatalogVC {
    func makeProducts(products: [Product]) -> [ProductCellData] {
        
        return products.enumerated().map { item in
            let (item, value) = item
            
            return ProductCellData(
                id: value.id,
                name: value.name,
                image: value.image,
                rating: value.rating,
                price: priceFormatter.string(from: NSNumber(value: value.price ?? 0)) ?? "0",
                onFavoriteSubscriber: { [weak self] cell, notify in
                    self?.subscribe(productID: item, cell: cell, notify: notify)
                },
                onFavoriteSelect: { [weak self] in
                    self?.setFavorite(productID: item)
                },
                onSelect: { [weak self] in
                    print("Select \(item) item")

                    self?.onDisplayProduct?(item)
                }
            )
        }
    }
    
    func makeTitle() -> ProductTitleData{
        .init(title: "Женская одежда", quantity: 20)
    }
}

//MARK: Cell button logic

private extension CatalogVC {
    func subscribe(
        productID: Int,
        cell: AnyObject,
        notify: @escaping CellButtonStateNotify
    ) {
        unsubscribe(cell: cell)
        
        favoriteState.append(
            .init(
                context: cell,
                notify: notify,
                productId: productID
            )
        )
        
        notify(cellButtonState(productId: productID))
    }
    
    func unsubscribe(cell: AnyObject) {
        favoriteState = favoriteState.filter { $0.context !== cell }
    }
    
    func setFavorite(productID: Int) {
        let oldButtonState = cellButtonState(productId: productID)
        
        updateFavoriteState(
            productId: productID,
            isSelected: oldButtonState.isSelected,
            isLoading: true
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.updateFavoriteState(
                productId: productID,
                isSelected: !oldButtonState.isSelected,
                isLoading: false
            )
        }
    }
    
    func updateFavoriteState(productId: Int, isSelected: Bool, isLoading: Bool) {
        let newButtonState = CellButtonState(isSelected: isSelected, isLoading: isLoading)
        self.productFavoriteCache[productId] = newButtonState
        
        if let cellState = self.searchFavoriteState(productId: productId) {
            cellState.notify(newButtonState)
        }
    }
    
    func searchFavoriteState(productId: Int) -> ButtonState? {
        favoriteState.first { $0.productId == productId }
    }
    
    func cellButtonState(productId: Int) -> CellButtonState {
        productFavoriteCache[productId] ?? .init(isSelected: false, isLoading: false)
    }
    
}

//MARK: Configurate nav bar

private extension CatalogVC {
    func congfigurateNavigationBar() {
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        appearance.setBackIndicatorImage(
            UIImage(named: "Auth/backButton"),
            transitionMaskImage: UIImage(named: "Auth/backButton")
        )
        
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.standardAppearance = appearance
//            navigationBar.isTranslucent = false
//            navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        }
        
        let settingsButton = UIBarButtonItem(
            image: UIImage(named: "Catalog/AdvancedFilter"),
            style: .done,
            target: self,
            action: #selector(toSettings(sender:))
        )
        
        settingsButton.tintColor = UIColor(named: "Colors/Grayscale/black")
        navigationItem.rightBarButtonItem = settingsButton
        
        navigationItem.titleView = MaterialSearchView.init(frame: .init(origin: .zero, size: .init(width: UIScreen.main.bounds.width, height: 36)))
    }
}
