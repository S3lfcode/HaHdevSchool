import Foundation

class BootstrapDataProvider {
    
    private let apiClient: ApiClient
    private let group: DispatchGroup
    
    init(apiClient: ApiClient, group: DispatchGroup) {
        self.apiClient = apiClient
        self.group = group
    }
    
    func doubleRequest (
        model: ProfileWithCity,
        completion: @escaping (ProfileWithCity) -> Void
    ) {
        var intermediateModel = model
        
        group.enter()
        apiClient.request(
            url: Bundle.main.url(forResource: "Profile", withExtension: "json"),
            expecting: ProfileResponseData.self
        ) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let responseData):
                intermediateModel.profile = responseData.data?.profile
            case .failure(let error):
                print("ApiError: \(error)")
            }
            self.group.leave()
        }
        
        
        group.enter()
        apiClient.request(
            url: Bundle.main.url(forResource: "City", withExtension: "json"),
            expecting: CityResponseData.self
        ) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let responseData):
                intermediateModel.city = responseData.data?.city
            case .failure(let error):
                print("ApiError: \(error)")
            }
            self.group.leave()
        }
        
        group.notify(queue: .main) {
            completion(intermediateModel)
        }
    }
}
