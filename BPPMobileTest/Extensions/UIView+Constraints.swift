import UIKit

extension UIView {
    func constrainToSuperview(insetedBy insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        guard let superview = superview else {
            fatalError("Constrain to superview, but no superview?")
        }
        
        activateContraints([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: insets.right),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: insets.bottom)
        ])
    }
    
    func centerVerticallyInSuperview(insetedBy insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        guard let superview = superview else {
            fatalError("Constrain to superview, but no superview?")
        }
        
        activateContraints([
            centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: insets.right)
        ])
    }
    
    func centerInSuperview(insetedBy insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        guard let superview = superview else {
            fatalError("Constrain to superview, but no superview?")
        }
        
        activateContraints([
            centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: insets.top),
            centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: insets.left)
        ])
    }
    
    func activateContraints(_ constraints: [NSLayoutConstraint]) {
        NSLayoutConstraint.activate(constraints)
    }
}
