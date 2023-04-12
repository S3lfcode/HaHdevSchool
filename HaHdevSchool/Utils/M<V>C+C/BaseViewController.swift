import UIKit

class BaseViewController<View: UIView>: UIViewController {
    
    var rootView: View {
        view as! View
    }
    
    override func loadView() {
        self.view = View()
    }
}
