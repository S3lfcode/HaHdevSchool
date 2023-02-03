//
//  DataStorage.swift
//  hw2
//
//  Created by Admin on 01.02.2023.
//

import Foundation

protocol DataStorage {
    
    func save<Value: Codable>(value: Value, key: String)
    func value<Value: Codable>(key: String) -> Value?
    
}
