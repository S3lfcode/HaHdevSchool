import Foundation
import UIKit

final class VerificationController<View: VerificationView>: BaseViewController<View> {
    
    init(phone: String, seconds: Int) {
        self.phone = phone
        self.seconds = seconds
                
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var phone: String
    private var seconds: Int
    
    private var timer: Timer?
    private var appDidEnterBackgroundDate: Date?
    
    var onComplete: ((_ operationToken: String) -> Void)?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        rootView.updateState(state: .info(text: phone))
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationDidEnterBackground(_:)),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationWillEnterForeground(_:)),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    // MARK: Logic
    
    @objc func applicationDidEnterBackground(_ notification: NotificationCenter) {
        appDidEnterBackgroundDate = Date()
    }
    
    @objc func applicationWillEnterForeground(_ notification: NotificationCenter) {
        guard let previousDate = appDidEnterBackgroundDate else { return }
        let calendar = Calendar.current
        let difference = calendar.dateComponents([.second], from: previousDate, to: Date())
        let secondsLeft = difference.second!
        seconds -= secondsLeft
    }
    
    @objc func onTimerFires() {
        seconds -= 1
        
        guard seconds >= 0 else {
            timer?.invalidate()
            timer = nil
            return
        }
        
        rootView.updateState(state: .seconds(num: seconds))
        
    }
}
