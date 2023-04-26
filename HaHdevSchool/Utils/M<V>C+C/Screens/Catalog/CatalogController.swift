import UIKit

final class CatalogController<View: CatalogView>: BaseViewController<View> {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rootView.configureNavController(navItem: navigationItem)
        rootView.onBack = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
 
}
