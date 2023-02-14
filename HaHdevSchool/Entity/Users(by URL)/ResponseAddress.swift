//
//  ResponceAddres.swift
//  HaHdevSchool
//
//  Created by Admin on 14.02.2023.
//

import Foundation

struct ResponseAddress: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: ResponseGeo
}
