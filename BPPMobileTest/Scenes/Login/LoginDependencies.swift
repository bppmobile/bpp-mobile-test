import Foundation

struct LoginDependencies {
    let colorTheme: ColorTheme
    let loginViewModel: LoginViewModel
    
    static func make(from appDependencies: AppDependencies) -> LoginDependencies {
        return LoginDependencies(
            colorTheme: appDependencies.colorTheme,
            loginViewModel: appDependencies.loginViewModel
        )
    }
}
