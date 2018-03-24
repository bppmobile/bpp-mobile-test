import UIKit

struct AppDependencies {
    let colorTheme: ColorTheme
    let emailValidator: EmailValidator

    static func make() -> AppDependencies {
        let colorTheme = LightTheme()
        let emailValidator = EmailValidator()
        
        return AppDependencies(
            colorTheme: colorTheme,
            emailValidator: emailValidator
        )
    }
}
