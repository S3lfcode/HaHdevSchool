import Foundation

protocol CatalogProvider {
    func products(offset: Int, force: Bool, completion: @escaping ([Product]?) -> Void)
}
