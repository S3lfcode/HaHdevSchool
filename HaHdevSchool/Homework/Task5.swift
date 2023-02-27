import Foundation

class Task5 {

    private let bootstrapDataProvider: BootstrapDataProvider
    
    init(bootstrapDataProvider: BootstrapDataProvider) {
        self.bootstrapDataProvider = bootstrapDataProvider
    }
    
    func homework() {
        print("~ Задание 5:")
        bootstrapDataProvider.doubleRequest(model: ProfileWithCity()) { result in
            print(result)
        }
    }
    
}
