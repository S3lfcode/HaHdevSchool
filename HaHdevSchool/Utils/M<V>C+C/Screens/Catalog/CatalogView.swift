import UIKit

protocol CatalogView: UIView {
    func configureNavController(navItem: UINavigationItem)
    
    var onBack: (() -> Void)? {get set}
    var onSettings: (() -> Void)? {get set}
}
