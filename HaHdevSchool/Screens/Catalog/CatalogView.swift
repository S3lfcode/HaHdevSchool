import UIKit

protocol CatalogView: UIView {
    func configureNavController(navItem: UINavigationItem)
    
    func display(
        cellData: [ProductCellData],
        titleData: ProductTitleData,
        animated: Bool
    )
    
    func displayLoading(enable: Bool)
    
    var onBack: (() -> Void)? {get set}
    var onSettings: (() -> Void)? {get set}
}
