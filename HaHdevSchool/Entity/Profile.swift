//
//  Profile.swift
//  hw2
//
//  Created by Admin on 01.02.2023.
//

import Foundation

struct Profile: Codable {
    
    typealias ID = String
    
    let id: ID
    let name: String
    let lastName: String
    let birthday: Date
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case lastName = "last_name"
        case birthday = "happyday"
    }
}
