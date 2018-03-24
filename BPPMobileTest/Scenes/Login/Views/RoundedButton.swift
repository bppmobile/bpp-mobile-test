import UIKit

final class RoundedButton: UIButton {
    // MARK: Public properties
    
    @IBInspectable var borderColor: UIColor? = .white {
        didSet {
            didChangeAppearance()
        }
    }
    
    @IBInspectable var highlightedAlpha: CGFloat = 0.5 {
        didSet {
            didChangeAppearance()
        }
    }
    
    @IBInspectable var disabledAlpha: CGFloat = 0.25 {
        didSet {
            didChangeAppearance()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            didChangeAppearance()
        }
    }
    
    // MARK: UIButton overrides
    
    override var isHighlighted: Bool {
        didSet {
            setBorderColor()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        didChangeAppearance()
    }
    
    // MARK: Private methods
    
    private func didChangeAppearance() {
        layer.borderWidth = borderWidth
        layer.cornerRadius = bounds.height / 2
        setBorderColor()
    }
    
    private func setBorderColor() {
        if !isEnabled {
            layer.borderColor = borderColor?.withAlphaComponent(disabledAlpha).cgColor
        
        } else {
            layer.borderColor = isHighlighted ?
                borderColor?.withAlphaComponent(highlightedAlpha).cgColor :
                borderColor?.cgColor
        }
    }
}
