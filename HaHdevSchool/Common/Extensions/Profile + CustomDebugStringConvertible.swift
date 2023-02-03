//
//  Profile + CustomDebugStringConvertible.swift
//  hw2
//
//  Created by Admin on 02.02.2023.
//

import Foundation
extension Profile: CustomStringConvertible {
    
    var description: String {
        return("Профиль №\(id) - Имя: \(name) ")
    }
    
}
