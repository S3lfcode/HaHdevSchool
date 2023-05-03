import UIKit

struct ButtonState {
    let context: AnyObject
    let notify: CellButtonStateNotify
    let productId: Int
}

final class CatalogVC<View: CatalogView>: BaseViewController<View> {
    
    init(priceFormatter: NumberFormatter){
        self.priceFormatter = priceFormatter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let priceFormatter: NumberFormatter
    
    var onDisplayProduct: ((_ id: Int) -> Void)?
    
//    var favoriteProducts: [Int] = []
//    var favoriteLoadingProducts: [Int] = []
    
    var productFavoriteCache: [Int: CellButtonState] = [:]
    var favoriteState: [ButtonState] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        congfigurateNavigationBar()
        
        loadData()
    }
    
    private func loadData() {
        rootView.displayLoading(enable: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.rootView.displayLoading(enable: false)
            
            self.rootView.display(
                cellData: self.makeProducts(ids: Array(0...20)),
                titleData: self.makeTitle(),
                animated: true
            )
        }
    }
    
    @objc func toSettings(sender: UIBarButtonItem) {
        //toSettings button action...
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

//MARK: Make data

private extension CatalogVC {
    func makeProducts(ids: [Int]) -> [ProductCellData] {
        
        return ids.enumerated().map { item in
            let (item, index) = item
            
            return ProductCellData(
                title: "Худи со скидкой из секондхенда",
                rating: 3,
                price: priceFormatter.string(from: NSNumber(value: 993_324)) ?? "0",
                onFavoriteSubscriber: { [weak self] cell, notify in
                    self?.subscribe(productID: item, cell: cell, notify: notify)
                }, 
                onFavoriteSelect: { [weak self] currentValue in
                    self?.setFavorite(value: currentValue, productID: item)
                }
            ) { [weak self] in
                
                print("Select \(item) \(index)")
                
                //Переход на экран товара
                self?.onDisplayProduct?(item)
            }
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
        
        //Добавили состояние нового элемента
        favoriteState.append(.init(context: cell, notify: notify, productId: productID))
        
        let cellState = searchFavoritestState(productId: productID)
        
        notify(cellState)
    }
    
    //Очищение предыдущего состояния
    func unsubscribe(cell: AnyObject) {
        favoriteState = favoriteState.filter {
            $0.context !== cell
        }
    }
    
    func searchFavoritestState(productId: Int) -> CellButtonState {
        let cacheValue = productFavoriteCache[productId]
        
        return cacheValue ?? .init(isSelected: false, isLoading: false)
    }
    
    func setFavorite(value: Bool, productID: Int) {
        // 1 ----
        //Ищем замыкание notify в массиве "fravoriteState"
        //Передаем в него нужные флаги (value, true) для обновления UI
        updateCellUI(value: value, productID: productID, isLoading: true)
        
        // 2 ----
        //Fake request async + delay //Искусственная задержка
        //Update local state //Изменяем локальное состояние
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.productFavoriteCache.updateValue(
                .init(isSelected: !value, isLoading: true),
                forKey: productID
            )
            self?.updateCellUI(value: !value, productID: productID, isLoading: false)
        }
        
        // 3 ----
        //Ищем замыкание notify в массиве "fravoriteState"
        //передаем в notify актуальные значения (newValue, false)

        
    }
    
    func updateCellUI(value: Bool, productID: Int, isLoading: Bool) {
        let notify = favoriteState.first {
            $0.productId == productID
        }?.notify
        
        notify?(.init(isSelected: value, isLoading: isLoading))
    }
    
}
