//
//  ApiClient2.0.swift
//  HaHdevSchool
//
//  Created by Admin on 10.02.2023.
//

import Foundation

class ApiClientV2 {
    
    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
    private let decoder: JSONDecoder
    
    enum CustomError: String, Error {
        case urlIsNil
        case invalidUrl
        case invalidData
    }
    
    func profile<T: Codable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T,Error>) -> Void
    ) {
        DispatchQueue.global(qos: .userInteractive).async { [self] in
            guard let url = url else {
                completion(.failure(CustomError.urlIsNil))
                return
            }
            
            if !url.isFileURL {
                completion(.failure(CustomError.invalidUrl))
                return
            }
            
            guard let data = try? Data(contentsOf: url) else {
                completion(.failure(CustomError.invalidData))
                return
            }
            
            do{
                let responceBody = try decoder.decode(expecting, from: data)
                DispatchQueue.main.async {
                    completion(.success(responceBody))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
}
