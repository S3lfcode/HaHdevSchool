//
//  HaHdevSchoolTests.swift
//  HaHdevSchoolTests
//
//  Created by S3lfcode on 07.05.2023.
//
 
import XCTest
@testable import HaHdevSchool

final class CatalogViewMock: UIView, CatalogView {
    var onRefresh: (() -> Void)?
    
    var willDisplayProduct: ((Int) -> Void)?
    
    var cellData: [HaHdevSchool.ProductCellData] = []
    
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
        //Дано
        let products: [Product] = [
            .init(id: 1, name: "229", image: nil, rating: 5, price: 100)
        ]
        
        let catalogProvider = CatalogProviderMock()
        catalogProvider.products = products
        
        let catalogVC = CatalogVC<CatalogViewMock>(
            catalogProvider: catalogProvider,
            priceFormatter: NumberFormatter()
        )
        
        //Действие
        catalogVC.viewDidLoad()
        
        //Проверка
        XCTAssertEqual(products.count, catalogVC.rootView.cellData.count)
    }

}

//Тут можно писать extension для кода, чтобы не менять основной код

//func exampleTest() {
    //Дано (инициализируем переменные, что-то настраиваем)

    //Действие (совершаем какое-либо действие с переменными)
    
    //Проверка (выполняем проверку результата)
//}

