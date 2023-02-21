import Foundation

extension Assembly {
    
    var apiClient: ApiClient {
        ApiClient(decoder: customDecoder)
    }
    
}
