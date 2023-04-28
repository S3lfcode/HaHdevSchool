import Foundation

struct ProductCellData {
    let title: String
    let rating: Int
    let price: String
    
    var onSelect: () -> Void
}
