//
//  ApiClient.swift
//  HaHdevSchool
//
//  Created by Admin on 07.02.2023.
//

import Foundation

class ApiClient {
    
    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
    private let decoder: JSONDecoder
    
    func profile(completion: @escaping (ResponceBody<ProfileResponceData>?) -> () ) {
        
        DispatchQueue.global(qos: .userInteractive).async {
//            [weak self] in
//            guard let self = self else {
//                return
//            }
            
            print("Start background job \(Thread.isMainThread)")
            
            guard let url = Bundle.main.url(forResource: "Profile", withExtension: "json") else {
                return
            }
            
            guard let data = try? Data.init(contentsOf: url) else {
                return
            }

            let responceBody = try? self.decoder.decode(ResponceBody<ProfileResponceData>.self, from: data)
            
            print(" job \(Thread.isMainThread)")
            
            DispatchQueue.main.async {
                completion(responceBody)
            }
            
            print("finish background job \(Thread.isMainThread)")
        }
    }
}
