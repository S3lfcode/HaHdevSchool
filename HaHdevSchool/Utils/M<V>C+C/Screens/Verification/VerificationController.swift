import Foundation
import UIKit

class VerificationController<View: VerificationView>: BaseViewController<View>, UITextViewDelegate {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    var appDidEnterBackgroundDate: Date?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
    }
    
    func setupNavBar(){
        let backButton = UIBarButtonItem()
        backButton.image = UIImage(named: "Auth/backButton")
        backButton.tintColor = .black
        backButton.title = ""
        backButton.style = .done

        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        rootView.connectScreen()
    }

    override func viewWillDisappear(_ animated: Bool) {
        rootView.disconnectScreen()
    }
}
