import UIKit

struct AppDependencies {
    let colorTheme: ColorTheme
    let loginViewModel: LoginViewModel

    static func make() -> AppDependencies {
        let colorTheme = LightTheme()
        let emailValidator = EmailValidator()
        let networkClient = NetworkClient()
        let loginService = LoginService(networkClient: networkClient)
        let loginViewModel = LoginViewModel(emailValidator: emailValidator, loginService: loginService)
        
        return AppDependencies(
            colorTheme: colorTheme,
            loginViewModel: loginViewModel
        )
    }
}
