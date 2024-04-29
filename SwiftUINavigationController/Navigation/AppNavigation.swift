import SwiftUI

class AppNavigation {
    static var shared = AppNavigation(startingRoute: .firstView)
    let startingRoute: AppRoute

    init(navigationController: UINavigationController = .init(), startingRoute: AppRoute) {
        self.startingRoute = startingRoute
    }

    func startingViewController() -> UIViewController{
        let view = startingRoute.view()
        let navigationController: UINavigationController = .init()
        let viewWithCoordinator = view.environmentObject(navigationController)
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        navigationController.setViewControllers([viewController], animated: false)
        navigationController.navigationBar.isHidden = true
        return navigationController
    }

    func navigate(_ route: AppRoute, animated: Bool = true, source: UINavigationController) {
        let view = route.view()
        let viewWithNavigator = view.environmentObject(source)
        let viewController = UIHostingController(rootView: viewWithNavigator)
        source.pushViewController(viewController, animated: animated)
    }
}
