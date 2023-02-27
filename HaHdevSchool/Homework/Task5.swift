import Foundation

class Task5 {
    
    private let bootstrapDataProvider: BootstrapDataProvider
    
    init(bootstrapDataProvider: BootstrapDataProvider) {
        self.bootstrapDataProvider = bootstrapDataProvider
    }
    
    func homework() {
        bootstrapDataProvider.doubleRequest(model: ProfileWithCity()) { result in
            print(result)
        }
    }
    
}
