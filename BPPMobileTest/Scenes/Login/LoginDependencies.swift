import Foundation

struct LoginDependencies {
    let colorTheme: ColorTheme
    let emailValidator: EmailValidator
    
    static func make(from appDependencies: AppDependencies) -> LoginDependencies {
        return LoginDependencies(
            colorTheme: appDependencies.colorTheme,
            emailValidator: appDependencies.emailValidator
        )
    }
}
