import UIKit

class BaseViewController<View: UIView>: UIViewController {
    
    var rootView: View? {
        view as? View
    }
    
    override func viewDidLoad() {
        // MARK: Можно ли использовать rootView для назначения экрана??
        self.view = View(frame: UIScreen.main.bounds)
    }
}
