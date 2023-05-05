import Foundation

class CatalogProviderImp: CatalogProvider {
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    private let apiClient: ApiClient
    
    enum Constants {
        static let limit: Int = 10
    }
    
    var loadedOffset: Int?
    
    var isLoading: Bool = false
    var isEnding: Bool = false
    
    func products(offset: Int, force: Bool, completion: @escaping ([Product]?) -> Void) {
        guard !isLoading else {
            return
        }
        
        guard let newOffset = nextAvailableOffset(offset: offset, force: force) else {
            return
        }
        
        isLoading = true
        
        if newOffset == 0 {
            dataRequest(jsonFileName: "ProductFirstPage") { data in
                self.loadedOffset = newOffset
                self.isLoading = false
                self.isEnding = false
                
                completion(data.list)
            }
        } else {
            dataRequest(jsonFileName: "ProductSecondPage") { data in
                self.loadedOffset = newOffset
                self.isLoading = false
                self.isEnding = true
                
                completion(data.list)
            }
        }
    }
    
    private func nextAvailableOffset(offset: Int, force: Bool) -> Int? {
        if force {
            return 0
        }
        
        if isEnding {
            return nil
        }
        
        if let loadedOffset = loadedOffset {
            if offset > loadedOffset + Constants.limit / 2 {
                return loadedOffset + Constants.limit
            }
        } else if offset == 0 {
            return 0
        }
        
        return nil
    }
    
    private func dataRequest(
        jsonFileName: String,
        completion: @escaping (_ data: ProductResponseData) -> Void
    ) {
        apiClient.request(
            url: Bundle.main.url(forResource: jsonFileName, withExtension: "json"),
            expecting: ProductResponseData.self
        ) { result in
            
            switch result {
            case .success(let responseData):
                guard let data = responseData.data else {
                    return
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    completion(data)
                }
                
            case .failure(let error):
                print("ApiError: \(error)")
            }
        }
    }
}
