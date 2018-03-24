import UIKit

struct AppDependencies {
    
    let colorTheme: ColorTheme

    static func make() -> AppDependencies {
        let colorTheme = LightTheme()
        
        return AppDependencies(colorTheme: colorTheme)
    }
}
