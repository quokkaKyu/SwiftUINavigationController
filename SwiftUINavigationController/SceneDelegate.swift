import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        // Ensure the scene is of type UIWindowScene
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)
        
        window.rootViewController = AppNavigation.shared.startingViewController()
        
        self.window = window
        window.makeKeyAndVisible()
    }
}
