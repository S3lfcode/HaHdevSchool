//
//  File.swift
//  HaHdevSchool
//
//  Created by Admin on 11.02.2023.
//

import Foundation

func task2(){
    print("~ Задание 2:")
    
    let localeStorage = UserDefaults.standard
    let keyForDate = "lastLauncRec"
   
    var interval: TimeInterval? {
        if let stringLastDate = localeStorage.string(forKey: keyForDate) {
            let interval = Date().timeIntervalSince(stringLastDate.toDate)
            savingDateInUserDefaults()
            return interval
        } else {
            savingDateInUserDefaults()
            return nil
        }
    }
    
    func savingDateInUserDefaults() {
        localeStorage.set(Date().toCustomDateString(format: "dd MM yyyy HH:mm:ss"), forKey: keyForDate)
        localeStorage.synchronize()
    }
    
    if let lastLaunchTime = interval {
        print("--> Последний вход был совершен ~\(String(format: "%.2f", lastLaunchTime)) секунд назад...")
    } else {
        print("Это был первый вход в приложение!")
    }
    
}
