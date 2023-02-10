//
//  Assembly + ApiClient.swift
//  HaHdevSchool
//
//  Created by Admin on 07.02.2023.
//

import Foundation

extension Assembly {
    
    var apiClient: ApiClient {
        ApiClient.init(decoder: decoder)
    }
}
