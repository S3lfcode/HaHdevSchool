import Foundation

extension Assembly {
    
    var dataStorage: DataStorage {
        UserDefaultsStorage<Any?>(
            encoder: encoder,
            decoder: decoder,
            userDefaults: UserDefaults.standard)
    }
}

