import UIKit

final class AppCoordinator {
    // MARK: Public properties
    
    var viewController: UIViewController {
        return loginViewController
    }
    
    // MARK: Init/Deinit
    
    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
        self.loginViewController = LoginViewController()
    }
    
    // MARK: Private properties
    
    private let dependencies: AppDependencies
    private let loginViewController: LoginViewController
}
