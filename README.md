# SwiftUINavigationController

UINavigationController를 이용한 SwiftUI View의 화면전환 프로젝트 입니다. 
https://medium.com/@anandhakrishnan.m/unlocking-the-power-of-uikit-navigation-in-swiftui-2dfc26a50f32
를 보고 구현해봤는데 해당 블로그 설명에 빠진부분이 있어서 프로젝트로 만들어봤습니다.

![SwiftUINavigationController.gif](/Resource/app.gif)

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
