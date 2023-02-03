//
//  Date + Extensions.swift
//  hw2
//
//  Created by Admin on 31.01.2023.
//

import Foundation

extension Date {
    
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy HH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
}
