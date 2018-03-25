import UIKit

final class ErrorMessageView: UIView {
    
    // MARK: Public properties
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 8 {
        didSet {
            setNeedsLayout()
        }
    }
    
    var colorTheme: ColorTheme? {
        didSet {
            didSetColorTheme()
        }
    }
    
    // MARK: Public methods
    
    func fadeIn() {
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
            self.alpha = 1.0
        }, completion: nil)
    }
    
    func fadeOut() {
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }
    
    // MARK: UIView overrides
    
    override func didMoveToSuperview() {
        addSubviews()
        addConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setAppearance()
    }

    // MARK: Private properties
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var animationDuration: Double = 0.3
    
    // MARK: Private methods
    
    private func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(label)
    }
    
    private func addConstraints() {
        containerView.constrainToSuperview()
        label.centerVerticallyInSuperview(insetedBy: UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4))
    }
    
    private func setAppearance() {
        setShadowAndCornerRadius(cornerRadius: cornerRadius)
    }
    
    private func didSetColorTheme() {
        backgroundColor = colorTheme?.errorBackground
        label.textColor = colorTheme?.errorText
    }
}
