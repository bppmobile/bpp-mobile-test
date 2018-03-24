import UIKit

protocol ColorTheme {
    var mainBackgroundGradient: [UIColor] { get }
    var errorBackground: UIColor { get }
    var errorText: UIColor { get }
    var roundedButton: UIColor { get }
}

struct LightTheme: ColorTheme {
    var mainBackgroundGradient: [UIColor] {
        return [Resources.Colors.pelorous.color, Resources.Colors.skyBlue.color]
    }
    
    var errorBackground: UIColor {
        return Resources.Colors.pastelRed.color
    }
    
    var errorText: UIColor {
        return .white
    }
    
    var roundedButton: UIColor {
        return .white
    }
}
