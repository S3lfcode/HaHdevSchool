//
//  AppDelegate.swift
//  hw2
//
//  Created by Admin on 29.01.2023.
//

import UIKit



@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // MARK: (Задание 2)
        //Запуск метода для расчёта времени между последним запуском и текущим
        
//        if let lastLaunchTime = TimeFromLastLaunch().interval {
//            print("--> Последний вход был совершен ~\(String(format: "%.2f", lastLaunchTime)) секунд назад...")
//        } else {
//            print("Это был первый вход в приложение!")
//        }
        
        // MARK: (Задание 3)
        //ЗАДАНИЕ:
        //1. Проверить наличие профиля в UserDefaults
        //2. Если такого профиля нет, то создать его и сохранить (+синхронизировать userDefaults)
        //3. Если профиль в юзер дефолтс есть, то вывести его через print с помощью CustomDebugStringConvertible
        
        enum ProfileKey: String {
            case UserProfile
        }
        
        let storage = Assembly().dataStorage
        let userKey = ProfileKey.UserProfile.rawValue
        let man = Profile(id: 777, name: "Владимир")
        
        if let profile = storage.value(key: userKey) as Profile? {
            print(String(reflecting: profile))
        } else {
            print("Это первый вход, профиль не был создан")
            storage.save(value: man, key: userKey)
        }
        
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

