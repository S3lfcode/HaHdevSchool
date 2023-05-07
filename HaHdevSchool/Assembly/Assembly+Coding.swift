import Foundation

extension Assembly {
    
    var encoder: JSONEncoder {
        JSONEncoder()
    }
    
    var decoder: JSONDecoder {
        JSONDecoder()
    }
    
    var customDecoder: JSONDecoder {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let customDecoder = JSONDecoder()
        customDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return customDecoder
    }
    
}
