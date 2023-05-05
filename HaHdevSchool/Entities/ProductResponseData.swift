import Foundation

struct ProductResponseData: Codable {
    let list: [Product]?
    let count: Int?
}
