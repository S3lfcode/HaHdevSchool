import Foundation

struct VerificationContext {
    let phone: String
    let seconds: Int
    let finishFlow: (_ operationToken: String) -> Void
}
