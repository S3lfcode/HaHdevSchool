import Foundation

class BootstrapDataProvider {
    
    let apiClient: ApiClient
    let group: DispatchGroup
    
    init(apiClient: ApiClient, group: DispatchGroup) {
        self.apiClient = apiClient
        self.group = group
    }
    
    func doubleRequest() {
        
        group.enter()
        apiClient.request(url: Bundle.main.url(forResource: "Profile", withExtension: "json"),
                          expecting: ProfileResponseData.self
        ) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let responseData):
                print("\n ---> Результат загрузки из \"Profile.json\" файла: \n\(responseData)")
            case .failure(let error):
                print("ApiError: \(error)")
            }
            self.group.leave()
        }
        
        
        group.enter()
        apiClient.request(url: Bundle.main.url(forResource: "City", withExtension: "json"),
                          expecting: CityResponseData.self
        ) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let responseData):
                print("\n ---> Результат загрузки из \"City.json\" файла: \n\(responseData)")
            case .failure(let error):
                print("ApiError: \(error)")
            }
            self.group.leave()
        }
        
        group.notify(queue: .main) {
            //Вывод результата в completion
            print("\nВычисления окончены")
        }
    }
}
