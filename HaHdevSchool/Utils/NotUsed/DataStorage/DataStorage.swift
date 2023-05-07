import Foundation

protocol DataStorage {
    func save<Value: Codable>(value: Value, key: String)
    func value<Value: Codable>(key: String) -> Value?
}
