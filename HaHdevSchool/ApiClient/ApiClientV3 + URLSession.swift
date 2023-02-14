//
//  ApiClientV3 + URLSession.swift
//  HaHdevSchool
//
//  Created by Admin on 11.02.2023.
//

import Foundation
import UIKit

class ApiClientV3 {
    
    init(decoder: JSONDecoder){
        self.decoder = decoder
    }
    
    private let decoder: JSONDecoder
    
    enum CustomError: Error {
        case urlIsNil
        case invalidURL
        case invalidData
    }
    
    func profile<T: Codable> (
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void) {
            
            guard let url = url else {
                completion(.failure(CustomError.urlIsNil))
                return
            }
            
            if !url.isFileURL || !UIApplication.shared.canOpenURL(url) {
                completion(.failure(CustomError.invalidURL))
            }
            
            let session = URLSession(configuration: .default)
            
            let dataTask = session.dataTask(with: url) { [self] data, _, error in
                guard let data = data else {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(CustomError.invalidData))
                    }
                    return
                }
                
                do{
                    let result = try decoder.decode(expecting, from: data)
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
