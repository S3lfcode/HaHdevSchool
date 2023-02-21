import Foundation

final class Task3 {
    
    enum defaultsKeys: String {
        case userProfile
    }
    
    private let storage: DataStorage
    
    init(storage: DataStorage) {
        self.storage = storage
    }
    
    func homework() {
        print("~ Задание 3:")
        
        let userKey = defaultsKeys.userProfile.rawValue
        let man = Profile(
            id: "777",
            name: "Владимир",
            lastName: "Питбуль",
            birthday: Date()
        )
        
        if let profile = storage.value(key: userKey) as Profile? {
            print(String(reflecting: profile))
        } else {
            print("Это первый вход, профиль не был создан")
            storage.save(value: man, key: userKey)
        }
    }
    
}
