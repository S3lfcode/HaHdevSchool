import UIKit

protocol BaseCoordinator: AnyObject {
    var parentCoordinator: BaseCoordinator? { get set }
    var childs: [BaseCoordinator] { get set }
    
    func make() -> UIViewController?
}

extension BaseCoordinator {
    func addChild(coordinator: BaseCoordinator) {
        coordinator.parentCoordinator = self
        childs.append(coordinator)
    }
}

extension BaseCoordinator {
    func start<Coordinate: RootableCoordinator>(
        coordinator: Coordinate?,
        on navigationController: UINavigationController?,
        animated: Bool
    ) where Coordinate.Root == UINavigationController {
        guard
            let coordinator = coordinator,
            let navigationController = navigationController,
            let controller = coordinator.make()
        else {
            return
        }
        
        addChild(coordinator: coordinator)
        
        coordinator.root = navigationController
        
        let animated = !navigationController.viewControllers.isEmpty && animated
        navigationController.pushViewController(controller, animated: animated)
    }
}

extension BaseCoordinator {
    func depth(where closure: (BaseCoordinator) -> Bool) -> Int {

        let maxDepth = childs
            .filter(closure)
            .compactMap{ $0.depth(where: closure) }
            .max(by: >) ?? 0

        return maxDepth + 1
    }
}

extension BaseCoordinator {
    func setContent<ViewController: ContainerViewController> (
        coordinator: BaseCoordinator?,
        on containerController: ViewController,
        containerId: ViewController.View.ContainerID,
        animated: Bool
    ) {
        guard
            let coordinator = coordinator,
            let controller = coordinator.make()
        else {
            return
        }
        controller.willMove(toParent: containerController)
        containerController.addChild(controller)
        controller.didMove(toParent: containerController)
        
        addChild(coordinator: coordinator)
        containerController.hostView.addSubview(view: controller.view, by: containerId, animated: animated)
    }
    
    func removeContent<ViewController: ContainerViewController> (
        coordinator: BaseCoordinator?,
        on containerController: ViewController,
        containerId: ViewController.View.ContainerID,
        animated: Bool
    ) {
        guard
            let coordinator = coordinator,
            let controller = coordinator.make()
        else {
            return
        }
        
        controller.willMove(toParent: nil)
        controller.removeFromParent()
        controller.didMove(toParent: nil)

        containerController.hostView.removeSubview(view: controller.view, by: containerId, animated: animated)
    }
}
