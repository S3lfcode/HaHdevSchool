import Foundation
import UIKit

class ApiClient {
    
    enum Error: Swift.Error {
        case callerFail
        case urlNotFound
        case invalidData
        case decodingFail
        
        var description: String {
            switch self {
            case .callerFail:
                return "Вызывающий эту функцию объект был уничтожен"
            case .urlNotFound:
                return "Указанный URL не найден"
            case .invalidData:
                return "Ссылка содержит недопустимые данные"
            case .decodingFail:
                return "Ошибка расшифровки данных"
            }
        }
    }
    
    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
    private let decoder: JSONDecoder
    
    func request <ResponseData: Codable>(
        url: URL?,
        expecting: ResponseData.Type,
        completion: @escaping (Result<ResponseBody<ResponseData>, ApiClient.Error>) -> Void
    ) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self = self else {
                completion(.failure(.callerFail))
                return
            }
            
            guard let url = url else {
                self.finish(result: .failure(.urlNotFound), completion: completion)
                return
            }
            
            guard let data = try? Data.init(contentsOf: url) else {
                self.finish(result: .failure(.invalidData), completion: completion)
                return
            }
            
            guard let result = try? self.decoder.decode(ResponseBody<ResponseData>.self, from: data)
            else {
                self.finish(result: .failure(.decodingFail), completion: completion)
                return
            }
            
            self.finish(result: .success(result), completion: completion)
        }
    }
    
    private func finish<ResponseData: Codable>(
        result: Result<ResponseBody<ResponseData>, ApiClient.Error>,
        completion: @escaping (Result<ResponseBody<ResponseData>, ApiClient.Error>) -> Void
    ) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
