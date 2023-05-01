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

        rootView.configureNavController(navItem: navigationItem)
        rootView.onBack = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        rootView.displayLoading(enable: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.rootView.displayLoading(enable: false)
            
            self.rootView.display(
                cellData: self.makeProducts(ids: Array(0...20)),
                titleData: self.makeTitle(),
                animated: true)
        }
        
    }

}

//MARK: - Make data

private extension CatalogVC {
    func makeProducts(ids: [Int]) -> [ProductCellData] {
        
        return ids.map { id in
            ProductCellData(
                title: "Худи со скидкой из секондхенда",
                rating: 3,
                price: priceFormatter.string(from: NSNumber(value: 993_324)) ?? "0"
            ) { [weak self] in
                
                print("Select \(id)")
                
                self?.onDisplayProduct?(id)
            }
        }
    }
    
    func makeTitle() -> ProductTitleData{
        .init(title: "Женская одежда", quantity: 20)
    }
}
