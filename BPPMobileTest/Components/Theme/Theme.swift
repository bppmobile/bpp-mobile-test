import UIKit

enum Colors {
    case background
    
    var gradientColors: [UIColor] {
        switch self {
        case .background:
            return [Resources.Colors.pelorous.color, Resources.Colors.skyBlue.color]
        }
    }
}
