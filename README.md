# SwiftUINavigationController
블로그: https://velog.io/@quokka/SwiftUI-UINavigationController-%EC%82%AC%EC%9A%A9%ED%9B%84%EA%B8%B0

<img src="/Resource/app.gif" width="30%" height="30%"/>

## 파일구조

![structure.png](/Resource/structure.png)
 
## 코드
- ### AppRoute.swift

```swift
enum AppRoute: Router {
    case firstView
    case secondView(number: Int)
    case thirdView(number: Int)

    @ViewBuilder
    func view() -> some View {
        switch self {
        case .firstView:
            FirstView() // RootView created by SwiftUI
        case .secondView(let number):
            SecondView(number: number)
        case .thirdView(let number):
            ThirdView(number: number)
        }
    }
}
```
- ### AppNavigation.swift

```swift
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

```
- ### UINavigationController+extension.swift

```swift
import UIKit

extension UINavigationController: ObservableObject {
    func navigateTo(route: AppRoute) {
        AppNavigation.shared.navigate(route, source: self)
    }

    func pop() {
        popViewController(animated: true)
    }

    func popToRoot() {
        popToRootViewController(animated: true)
    }
}

```

- ### SceneDelegate.swift
```swift
import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        // Ensure the scene is of type UIWindowScene
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)
        
        window.rootViewController = AppNavigation.shared.startingViewController() // Setting rootViewController.
        
        self.window = window
        window.makeKeyAndVisible()
    }
}
```
## Reference
https://medium.com/@anandhakrishnan.m/unlocking-the-power-of-uikit-navigation-in-swiftui-2dfc26a50f32
