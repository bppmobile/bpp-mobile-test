import UIKit

final class RoundedButton: UIButton, HasViewState {
    
    // MARK: HasViewState
    
    var viewState: ViewState = .idle {
        didSet {
            didChangeViewState()
        }
    }
    
    // MARK: Public properties
    
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
    
    var colorTheme: ColorTheme? {
        didSet {
            setColors()
        }
    }
    
    // MARK: UIButton overrides
    
    override var isHighlighted: Bool {
        didSet {
            setBorderColor()
        }
    }
    
    override func didMoveToSuperview() {
        addSubviews()
        addConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        didChangeAppearance()
    }
    
    // MARK: Private properties
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .white)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private var title: String?
    
    // MARK: Private methods
    
    private func addSubviews() {
        addSubview(spinner)
    }
    
    private func addConstraints() {
        spinner.centerInSuperview()
    }
    
    private func didChangeAppearance() {
        layer.borderWidth = borderWidth
        layer.cornerRadius = bounds.height / 2
        
        setColors()
    }
    
    private func setColors() {
        let color = colorTheme?.roundedButton
        setTitleColor(color, for: .normal)
        setTitleColor(color?.withAlphaComponent(highlightedAlpha), for: .highlighted)
        
        setBorderColor()
    }
    
    private func setBorderColor() {
        let color = colorTheme?.roundedButton
        
        if !isEnabled {
            layer.borderColor = color?.withAlphaComponent(disabledAlpha).cgColor
        
        } else {
            layer.borderColor = isHighlighted ?
                color?.withAlphaComponent(highlightedAlpha).cgColor :
                color?.cgColor
        }
    }
}

// MARK: State handling

extension RoundedButton {
    func didChangeViewState() {
        switch viewState {
        case .idle, .hasError:
            if let title = title {
                setTitle(title, for: .normal)
            }
            
            spinner.stopAnimating()
            isUserInteractionEnabled = true
            
        case .isLoading:
            title = title(for: .normal)
            setTitle(nil, for: .normal)
            spinner.startAnimating()
            isUserInteractionEnabled = false

        }
    }
}
