import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: UIApplicationDelegate
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupCoordinator()
        setupWindow()
        return true
    }
    
    // MARK: Private properties
    
    //swiftlint:disable implicitly_unwrapped_optional
    private var appCoordinator: AppCoordinator!
    private var dependencies: AppDependencies!
    //swiftlint:enable implicitly_unwrapped_optional
    
    // MARK: Private methods
    
    private func setupCoordinator() {
        dependencies = AppDependencies.make()
        appCoordinator = AppCoordinator(dependencies: dependencies)
    }
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator.viewController
        window?.makeKeyAndVisible()
    }
}
