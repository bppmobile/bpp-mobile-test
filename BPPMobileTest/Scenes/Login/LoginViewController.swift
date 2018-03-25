import UIKit

final class LoginViewController: UIViewController, HasViewState {
    
    // MARK: HasViewState
    
    private(set) var viewState: ViewState = .idle {
        didSet {
            didChangeViewState()
        }
    }
    
    // MARK: Public properties
    
    //swiftlint:disable implicitly_unwrapped_optional
    var dependencies: LoginDependencies!
    //swiftlint:enable implicitly_unwrapped_optional
    
    // MARK: UIViewController overrides
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviews()
        observeNotifications()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setAppearance()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.cancelRequest()
    }
    
    // MARK: IBOutlets

    @IBOutlet private weak var errorMessageView: ErrorMessageView!
    @IBOutlet private weak var fieldsContainerView: UIView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: RoundedButton!
    
    // MARK: Private properties
    
    private var colorTheme: ColorTheme {
        return dependencies.colorTheme
    }
    
    private var viewModel: LoginViewModel {
        return dependencies.loginViewModel
    }
    
    private let cornerRadius: CGFloat = 8
    
    // MARK: Private methods
    
    private func setSubviews() {
        errorMessageView.colorTheme = colorTheme
        
        emailTextField.placeholder = Localization.loginEmailTextfieldPlaceholder
        passwordTextField.placeholder = Localization.loginPasswordTextfieldPlaceholder
        
        loginButton.isEnabled = false
        loginButton.setTitle(Localization.loginButtonTitle, for: .normal)
        loginButton.colorTheme = colorTheme
    }
    
    private func setAppearance() {
        fieldsContainerView.layer.cornerRadius = cornerRadius
        view.setLinearGradient(withColors: colorTheme.mainBackgroundGradient)
    }
    
    private func observeNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textFieldDidChange),
            name: Notification.Name.UITextFieldTextDidChange,
            object: nil
        )
    }
    
    // MARK: IBActions
    
    @IBAction private func loginButtonTouchedUpInside(_ sender: RoundedButton) {
        attemptToLogUserIn()
    }
    
    private func attemptToLogUserIn() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            let error = LoginError.emptyEmailOrPassword
            viewState = .hasError(error)
            return
        }
        
        guard viewModel.isEmailValid(email) else {
            let error = LoginError.invalidFormattedEmail
            viewState = .hasError(error)
            return
        }
        
        guard viewModel.isPasswordValid(password) else {
            let error = LoginError.emptyEmailOrPassword
            viewState = .hasError(error)
            return
        }
        
        viewState = .isLoading
        
        viewModel.login(withEmail: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.viewState = .idle
                
            case .failure(let error):
                self?.viewState = .hasError(error)
            }
        }
    }
}

// MARK: State handling

private extension LoginViewController {
    private func didChangeViewState() {
        switch viewState {
        case .idle:
            loginButton.viewState = .idle
            errorMessageView.fadeOut()
            
        case .isLoading:
            loginButton.viewState = .isLoading
            errorMessageView.fadeOut()
            
        case .hasError(let error):
            loginButton.viewState = .hasError(error)
            errorMessageView.text = error.asLoginError?.localizedDescription
            errorMessageView.fadeIn()
        }
    }
}

// MARK: UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        attemptToLogUserIn()
        return true
    }
    
    @objc private func textFieldDidChange() {
        loginButton.isEnabled = areBothFieldsFilledIn()
    }
    
    private func areBothFieldsFilledIn() -> Bool {
        if let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty {
            return true
        }
        
        return false
    }
}
