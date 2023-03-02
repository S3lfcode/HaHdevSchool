import Foundation

class BootstrapDataProvider {
    
    enum Error: Swift.Error {
        case unknown
    }
    
    private let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func doubleRequest (
        completion: @escaping (Result<(profile: Profile?, city: City?), Swift.Error>) -> Void
    ) {
        let group = DispatchGroup()
        
        var profileResult: Result<ResponseBody<ProfileResponseData>, ApiClient.Error>?
        var cityResult: Result<ResponseBody<CityResponseData>, ApiClient.Error>?
        
        group.enter()
        apiClient.request(
            url: Bundle.main.url(forResource: "Profile", withExtension: "json"),
            expecting: ProfileResponseData.self
        ) { result in
            profileResult = result
            group.leave()
        }
        
        
        group.enter()
        apiClient.request(
            url: Bundle.main.url(forResource: "City", withExtension: "json"),
            expecting: CityResponseData.self
        ) { result in
            cityResult = result
            group.leave()
        }
        
        
        group.notify(queue: .main) {
            guard let profileResult = profileResult, let cityResult = cityResult else {
                return
            }

            switch (profileResult, cityResult) {
            case (.success(let profileResponse), .success(let cityResponse)):
                completion(.success((profile: profileResponse.data?.profile, city: cityResponse.data?.city)))
            case (.failure(let error), _):
                completion(.failure(error))
            case (_, .failure(let error)):
                completion(.failure(error))
            default:
                completion(.failure(Error.unknown))
            }
        }
    }
}
