//
//  Task3.swift
//  HaHdevSchool
//
//  Created by Admin on 11.02.2023.
//

import Foundation

enum defaultsKeys: String {
    case userProfile
}

func task3() {
    print("~ Задание 3:")
    let storage = Assembly().dataStorage
    let userKey = defaultsKeys.userProfile.rawValue
    let man = Profile(id: "777", name: "Владимир", lastName: "Питбуль", birthday: Date())
    
    if let profile = storage.value(key: userKey) as Profile? {
        print(String(reflecting: profile))
    } else {
        print("Это первый вход, профиль не был создан")
        storage.save(value: man, key: userKey)
    }
}
