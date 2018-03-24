import Foundation

struct LoginDependencies {
    let colorTheme: ColorTheme
    
    static func make(from appDependencies: AppDependencies) -> LoginDependencies {
        return LoginDependencies(colorTheme: appDependencies.colorTheme)
    }
}
