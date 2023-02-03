//
//  UserDefaults.swift
//  hw2
//
//  Created by Admin on 29.01.2023.
//

import Foundation

class TimeFromLastLaunch {
    
    private let localeStorage = UserDefaults.standard
    private let keyForDate = "lastLauncRec"
   
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
    
    private func savingDateInUserDefaults() {
        localeStorage.set(Date().toString, forKey: keyForDate)
        localeStorage.synchronize()
    }

}
