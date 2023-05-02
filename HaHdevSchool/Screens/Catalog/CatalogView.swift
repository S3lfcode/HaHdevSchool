import UIKit

protocol CatalogView: UIView {
    func display(
        cellData: [ProductCellData],
        titleData: ProductTitleData,
        animated: Bool
    )
    
    func displayLoading(enable: Bool)
}
