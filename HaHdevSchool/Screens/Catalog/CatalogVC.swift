import UIKit

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
                price: priceFormatter.string(from: NSNumber(value: 993_324)) ?? "0"
            ) { [weak self] in
                
                print("Select \(item) \(index)")
                
                self?.onDisplayProduct?(item)
            }
        }
    }
    
    func makeTitle() -> ProductTitleData{
        .init(title: "Женская одежда", quantity: 20)
    }
}
