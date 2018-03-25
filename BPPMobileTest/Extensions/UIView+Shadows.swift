import UIKit

extension UIView {
    func setShadowAndCornerRadius(color: UIColor = UIColor.black,
                                  offset: CGSize = CGSize(width: 1, height: 1),
                                  opacity: Float = 0.5,
                                  radius: CGFloat = 3,
                                  cornerRadius: CGFloat) {
        
        let path: UIBezierPath = {
            if cornerRadius > 0 {
                return UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            } else {
                return UIBezierPath(rect: bounds)
            }
        }()
        
        setShadow(
            color: color,
            offset: offset,
            opacity: opacity,
            radius: radius,
            path: path
        )
        
        layer.cornerRadius = cornerRadius
    }
    
    func setShadow(color: UIColor = UIColor.black,
                   offset: CGSize = CGSize(width: 1, height: 1),
                   opacity: Float = 0.5,
                   radius: CGFloat = 3,
                   path: UIBezierPath? = nil) {
        
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        
        if let path = path {
            layer.shadowPath = path.cgPath
        }
        
        clipsToBounds = false
    }
}
