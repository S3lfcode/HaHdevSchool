import UIKit

protocol ContainerView {
    associatedtype ContainerID
    
    func addSubview(view: UIView, by id: ContainerID, animated: Bool)
    
    func removeSubview(view: UIView, by id: ContainerID, animated: Bool)
}
