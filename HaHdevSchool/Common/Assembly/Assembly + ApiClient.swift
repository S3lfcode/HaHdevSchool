//
//  Assembly + ApiClient.swift
//  HaHdevSchool
//
//  Created by Admin on 07.02.2023.
//

import Foundation

extension Assembly {
    
    var customDecoder: JSONDecoder {
        let customDecoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        customDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return customDecoder
    }
    
    var apiClient: ApiClient {
        ApiClient.init(decoder: customDecoder)
    }
    
    var apiClientV2: ApiClientV2 {
        return ApiClientV2.init(decoder: customDecoder)
    }
    
    var apiclientV3: ApiClientV3 {
        return ApiClientV3.init(decoder: customDecoder)
    }
    
}
