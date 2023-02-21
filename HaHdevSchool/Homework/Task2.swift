import Foundation

final class Task2 {
    
    func homework(){
        print("~ Задание 2:")
        
        let localeStorage = UserDefaults.standard
        let keyForDate = "lastLauncRec"
        
        var interval: TimeInterval? {
            if let stringLastDate = localeStorage.string(forKey: keyForDate) {
                let interval = Date().timeIntervalSince(stringLastDate.toDate())
                savingDateInUserDefaults()
                return interval
            } else {
                savingDateInUserDefaults()
                return nil
            }
        }
        
        func savingDateInUserDefaults() {
            localeStorage.set(Date().toString(format: "dd MM yyyy HH:mm:ss"), forKey: keyForDate)
            localeStorage.synchronize()
        }
        
        if let lastLaunchTime = interval {
            print("--> Последний вход был совершен ~\(String(format: "%.2f", lastLaunchTime)) секунд назад...")
        } else {
            print("Это был первый вход в приложение!")
        }
        
    }
    
}
