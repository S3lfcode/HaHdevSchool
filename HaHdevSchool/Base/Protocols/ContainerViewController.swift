import UIKit

protocol ContainerViewController: UIViewController  {
    associatedtype View: ContainerView
    
    var hostView: View { get }
}
