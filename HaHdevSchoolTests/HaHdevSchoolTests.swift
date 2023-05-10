import XCTest
@testable import HaHdevSchool

final class CatalogViewMock: UIView, CatalogView {
    
    var onRefresh: (() -> Void)?
    
    var willDisplayProduct: ((Int) -> Void)?
    
    var cellData: [HaHdevSchool.ProductCellData] = []
    
    var isSelected: Bool = false
    
    func display(
        cellData: [HaHdevSchool.ProductCellData],
        titleData: HaHdevSchool.ProductTitleData,
        append: Bool,
        animated: Bool
    ) {
        self.cellData = cellData
    }
    
    func displayLoading(enable: Bool) {
        
    }
}

final class CatalogProviderMock: CatalogProvider {
    
    var products: [Product]?
    
    func products(
        offset: Int,
        force: Bool,
        completion: @escaping ([HaHdevSchool.Product]?) -> Void
    ) {
        completion(products)
    }
    
}

final class CatalogVCTests: XCTestCase {

    func test_loading_success() {
        let products: [Product] = [
            .init(id: 1, name: "229", image: nil, rating: 5, price: 100)
        ]

        let catalogProvider = CatalogProviderMock()
        catalogProvider.products = products
        
        let formatter = NumberFormatter()
        
        let catalogVC = CatalogVC<CatalogViewMock>(
            catalogProvider: catalogProvider,
            priceFormatter: formatter
        )
        
        let product = products[0]
        let result = catalogVC.rootView.cellData[0]
        
        XCTAssertEqual(product.id, result.id)
        XCTAssertEqual(product.image, result.image)
        XCTAssertEqual(product.name, result.name)
        XCTAssertEqual(formatter.string(from: NSNumber(value: product.price ?? 0)), result.price)
        XCTAssertEqual(product.rating, result.rating)
    }
    
    func test_loading_failture() {
        let products: [Product]? = nil
        
        let catalogProvider = CatalogProviderMock()
        catalogProvider.products = products
        
        let catalogVC = CatalogVC<CatalogViewMock>(
            catalogProvider: catalogProvider,
            priceFormatter: NumberFormatter()
        )
        
        XCTAssertTrue(catalogVC.rootView.cellData.isEmpty)
    }
    
    func test_selectFirstCell_success() {
        let products: [Product] = [
            .init(id: 1, name: "229", image: nil, rating: 5, price: 100)
        ]
        
        let catalogProvider = CatalogProviderMock()
        catalogProvider.products = products
        
        let catalogVC = CatalogVC<CatalogViewMock>(
            catalogProvider: catalogProvider,
            priceFormatter: NumberFormatter()
        )
        
        var firstCell = catalogVC.rootView.cellData[0]
        
        firstCell.onSelect = {
            catalogVC.rootView.isSelected = true
        }
        
        firstCell.onSelect()
        
        XCTAssertTrue(catalogVC.rootView.isSelected)
    }
    
}

//Чтобы не менять основной код, можно писать extension для нужного класса

//func exampleTest() {
    //Дано (инициализируем переменные, что-то настраиваем)

    //Действие (совершаем какое-либо действие с переменными)
    
    //Проверка (выполняем проверку результата)
//}

