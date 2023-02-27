import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let assembly = Assembly()
    
    private lazy var task2 = assembly.task2
    private lazy var task3 = assembly.task3
    private lazy var task4 = assembly.task4
    private lazy var task5 = assembly.task5
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MARK: (Задание 2) Вывод интервала с последнего запуска
        //task2.homework()
        
        // MARK: (Задание 3) Работа с UserDefaults (dataStorage)
        //task3.homework()
        
        // MARK: (Задание 4) Работа с API
        //task4.homework()
        
        // MARK: (Задание 5) Работа с DispatchGroup
        task5.homework()
        
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

