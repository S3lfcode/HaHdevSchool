import Foundation

final class Task4 {
    
    enum DataKeys: String {
        case jsonData = "jsonData"
    }
    
    private let apiClient: ApiClient
    private let storage: DataStorage
    
    init(apiClient: ApiClient, storage: DataStorage) {
        self.apiClient = apiClient
        self.storage = storage
    }
    
    func homework() {
        print("~ Задание 4:")
        
        apiClient.request(
            url: Bundle.main.url(forResource: "Profile", withExtension: "json"),
            expecting: ProfileResponseData.self
        ) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let responseData):
                print("\n ---> Результат загрузки из \"JSON\" файла: \n\(responseData)")
                
                self.storage.save(value: responseData, key: DataKeys.jsonData.rawValue)
                if let storageData = self.storage.value(key: DataKeys.jsonData.rawValue) as ResponseBody<ProfileResponseData>? {
                    print("\n ---> Результат сохранения в \"dataStorage\": \n\(storageData)")
                } else {
                    print("\n ---> Ошибка. Сохранение в \"dataStorage\" не удалось")
                }
            case .failure(let error):
                print("ApiError: \(error)")
            }
        }
    }
    
}
