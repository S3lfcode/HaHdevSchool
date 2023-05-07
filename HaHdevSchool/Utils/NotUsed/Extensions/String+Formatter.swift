import Foundation

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy HH:mm:ss"
        let result = dateFormatter.date(from: self)
        
        guard let resDate = result else {
            return Date()
        }
        return resDate
    }
}
