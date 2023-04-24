import UIKit

final class CatalogController<View: CatalogView>: BaseViewController<View> {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavController()
    }
    
    private func configureNavController() {
        let backButton = UIBarButtonItem(
            image: UIImage(named: "Auth/backButton"),
            style: .done,
            target: self,
            action: #selector(popVC(sender:)))
        backButton.tintColor = UIColor(named: "Colors/Grayscale/black")
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc
    func popVC(sender: UIBarButtonItem) {
       navigationController?.popViewController(animated: true)
    }
}
