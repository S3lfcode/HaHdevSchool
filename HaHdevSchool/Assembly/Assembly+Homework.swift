import Foundation

extension Assembly {
    
    var task2: Task2 {
        Task2()
    }
    
    var task3: Task3 {
        Task3(storage: dataStorage)
    }
    
    var task4: Task4 {
        Task4(apiClient: apiClient, storage: dataStorage)
    }
    
}
