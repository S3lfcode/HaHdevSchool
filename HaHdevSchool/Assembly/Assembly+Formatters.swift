import Foundation

extension Assembly {
    
    var priceFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "₽"
        formatter.maximumFractionDigits = 0
        formatter.currencyGroupingSeparator = " "
        return formatter
    }
    
}
