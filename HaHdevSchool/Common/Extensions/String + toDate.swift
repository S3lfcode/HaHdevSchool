//
//  String + Formatter.swift
//  hw2
//
//  Created by Admin on 31.01.2023.
//

import Foundation

extension String {
    
    var toDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy HH:mm:ss"
        let result = dateFormatter.date(from: self)
        
        guard let resDate = result else {
            return Date()
        }
        return resDate
    }
    
}
