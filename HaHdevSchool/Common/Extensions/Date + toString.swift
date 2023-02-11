//
//  Date + Extensions.swift
//  hw2
//
//  Created by Admin on 31.01.2023.
//

import Foundation

extension Date {
    
    func toCustomDateString (format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
