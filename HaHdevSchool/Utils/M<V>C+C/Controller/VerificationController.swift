import Foundation
import UIKit

class VerificationController<View: VerificationView>: BaseViewController<View>, UITextViewDelegate {
    
    init(
        authProvider: AuthProvider
    ) {
        self.authProvider = authProvider
        
        super.init(nibName: nil, bundle: nil)
    }
    
    private let authProvider: AuthProvider
    
    private var timer: Timer?
    private var timeLeft = 40
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    
    @objc func onTimerFires() {
        
        timeLeft -= 1
        
        switch timeLeft {
        case timeLeft where timeLeft>=10:
            rootView?.updateTimer(text: "00:\(timeLeft)")
            break
        case timeLeft where timeLeft>0 && timeLeft<10:
            rootView?.updateTimer(text: "00:0\(timeLeft)")
            break
        case timeLeft where timeLeft <= 0:
            timer?.invalidate()
            rootView?.updateTimer(text: "00:00")
            timer = nil
            break
        default:
            break
        }
    }
    
    var appDidEnterBackgroundDate: Date?
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground(_:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground(_:)), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func applicationDidEnterBackground(_ notification: NotificationCenter) {
        appDidEnterBackgroundDate = Date()
    }
    
    @objc func applicationWillEnterForeground(_ notification: NotificationCenter) {
        guard let previousDate = appDidEnterBackgroundDate else { return }
        let calendar = Calendar.current
        let difference = calendar.dateComponents([.second], from: previousDate, to: Date())
        let seconds = difference.second!
        timeLeft -= seconds
    }
    
}
