//
//  URLSession + custom.swift
//  HaHdevSchool
//
//  Created by Admin on 11.02.2023.
//

import Foundation

extension URLSession {
    
    enum CustomError: Error {
        case urlIsNil
        case invalidURL
        case invalidData
    }
    
    func profile<T:Codable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = url else {
            completion(.failure(CustomError.urlIsNil))
            return
        }
        
        if !url.isFileURL {
            completion(.failure(CustomError.invalidURL))
        }
        
        let dataTask = dataTask(with: url) { data, _, error in
            
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            
            do {
                let result = try Assembly().customDecoder.decode(expecting, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
}
