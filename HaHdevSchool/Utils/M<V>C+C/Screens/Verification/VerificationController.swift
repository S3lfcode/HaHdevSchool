import Foundation
import UIKit

class VerificationController<View: VerificationView>: BaseViewController<View> {
    
    private var phone: String
    private var seconds: Int
    
    init(phone: String, seconds: Int) {
        self.phone = phone
        self.seconds = seconds
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
