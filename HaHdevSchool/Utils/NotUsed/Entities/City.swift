//
//  City.swift
//  HaHdevSchool
//
//  Created by Admin on 27.02.2023.
//

import Foundation

struct City: Codable {
    
    let id: Int
    let name: String
    
}


extension City: CustomStringConvertible {
    
    var description: String {
        return
"""
\n---------------------------------
|\tID: №\(id)
|\tНазвание: \(name)
-----------------------------------\n
"""
    }
    
}
