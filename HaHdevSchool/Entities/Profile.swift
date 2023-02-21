import Foundation

struct Profile: Codable {
    
    typealias ID = String
    
    let id: ID
    let name: String
    let lastName: String
    let birthday: Date
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case lastName = "last_name"
        case birthday = "happyday"
    }
    
}

extension Profile: CustomStringConvertible {
    
    var description: String {
        return
"""
\n--------------------------------------------------
|\tПрофиль: №\(id)
|\tИмя: \(name)
|\tФамилия: \(lastName)
|\tДата рождения: \(birthday.toString(format: "dd.MM.yyyy"))
--------------------------------------------------\n
"""
    }
    
}
