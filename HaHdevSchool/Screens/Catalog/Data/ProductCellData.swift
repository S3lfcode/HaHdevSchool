import Foundation

struct ProductCellData {
    let title: String
    let rating: Int
    let price: String
    
    let onFavoriteSubscriber: (
        _ cell: AnyObject,
        _ notify: @escaping CellButtonStateNotify
    ) -> Void
    
    let onFavoriteSelect: () -> Void
    
    var onSelect: () -> Void
}

struct CellButtonState {
    let isSelected: Bool
    let isLoading: Bool
}

typealias CellButtonStateNotify = (CellButtonState) -> Void
