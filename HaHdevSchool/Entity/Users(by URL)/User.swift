//
//  User.swift
//  HaHdevSchool
//
//  Created by Admin on 14.02.2023.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: ResponseAddress
    let phone: String
    let website: String
    let company: ResponseCompany
}
