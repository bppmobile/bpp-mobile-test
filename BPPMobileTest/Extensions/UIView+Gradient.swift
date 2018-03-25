import UIKit

enum GradientAxis {
    case vertical, horizontal
}

extension UIView {
    func setLinearGradient(withColors colors: [UIColor], axis: GradientAxis = .vertical) {
        let gradient = CAGradientLayer()
        
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = [0.0, 1.0]
        
        switch axis {
        case .horizontal:
            gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradient.endPoint = CGPoint(x: 1.5, y: 1.0)

        case .vertical:
            gradient.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.5)
        }
        
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
    }
}
