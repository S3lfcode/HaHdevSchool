import UIKit

public protocol ApplicationGroundViewInput: AnyObject {
    func connectScreen()
    func disconnectScreen()
}

public protocol ApplicationGroundView: ApplicationGroundViewInput {
    var groundToken: Any? {get set}
    var appDidEnterBackgroundDate: Date? {get set}
    
    func apply(secondsPassed: Int)
}

extension ApplicationGroundView where Self: UIView {
    
    func connectScreen() {
        groundToken = [
            NotificationCenter.default.addObserver(
                forName: UIApplication.didEnterBackgroundNotification,
                object: nil,
                queue: .main
            ) { [weak self] notification in
                self?.update(willEnterBackground: true)
            },
            
            NotificationCenter.default.addObserver(
                forName: UIApplication.willEnterForegroundNotification,
                object: nil,
                queue: .main
            ) { [weak self] notification in
                self?.update(willEnterBackground: false)
            }
        ]
    }
    
    func disconnectScreen() {
        groundToken = nil
    }
    
    private func update(willEnterBackground: Bool) {
        
        if willEnterBackground {
            appDidEnterBackgroundDate = Date()
        } else {
            guard let previousDate = appDidEnterBackgroundDate else { return }
            let calendar = Calendar.current
            let difference = calendar.dateComponents([.second], from: previousDate, to: Date())
            let seconds = difference.second!
            apply(secondsPassed: seconds)
        }
    }
}
