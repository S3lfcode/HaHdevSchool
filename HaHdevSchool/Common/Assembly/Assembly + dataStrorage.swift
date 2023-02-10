//
//  Assembly + DataStrorage.swift
//  hw2
//
//  Created by Admin on 01.02.2023.
//

import Foundation

extension Assembly {
    
    var dataStorage: DataStorage {
        return UserDefaultsStorage<Any?>(
            encoder: encoder,
            decoder: decoder,
            userDefaults: UserDefaults.standard)
    }
    
    private var encoder: JSONEncoder {
        JSONEncoder()
    }
    var decoder: JSONDecoder {
        JSONDecoder()
    }
}

