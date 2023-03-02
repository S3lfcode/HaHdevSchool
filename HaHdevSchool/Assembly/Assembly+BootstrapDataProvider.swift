import Foundation

extension Assembly {
    
    var bootstrapDataProvider: BootstrapDataProvider {
        BootstrapDataProvider(apiClient: apiClient)
    }
    
}
