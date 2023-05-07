import UIKit

protocol CatalogView: UIView {
    var onRefresh: (() -> Void)? { get set }
    var willDisplayProduct: ((_ item: Int) -> Void)? { get set }
    
    func display(
        cellData: [ProductCellData],
        titleData: ProductTitleData,
        append: Bool,
        animated: Bool
    )
    func displayLoading(enable: Bool)
}
