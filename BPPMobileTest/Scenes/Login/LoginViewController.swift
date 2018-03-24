import UIKit

final class LoginViewController: UIViewController {
    
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
    
    // MARK: IBOutlets

    @IBOutlet private weak var fieldsContainerView: UIView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: RoundedButton!
    
    // MARK: Private methods
    
    private func setSubviews() {
        loginButton.isEnabled = false
    }
    
    private func setAppearance() {
        fieldsContainerView.layer.cornerRadius = 8
        view.setLinearGradient(withColors: Colors.background.gradientColors, axis: .vertical)
    }
    
    private func observeNotifications() {
        NotificationCenter.default
            .addObserver(self, selector: #selector(textFieldDidChange), name: Notification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    // MARK: IBActions
    
    @IBAction private func loginButtonTouchedUpInside(_ sender: RoundedButton) {
        
    }
}

// MARK: UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if areBothFieldsFilledIn() {
            print("login")
        
        } else {
            focusOnNextField()
        }
        
        return true
    }
    
    private func focusOnNextField() {
        if emailTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        } else {
            emailTextField.becomeFirstResponder()
        }
    }
    
    @objc private func textFieldDidChange() {
        if areBothFieldsFilledIn() {
            loginButton.isEnabled = true
            emailTextField.returnKeyType = .go
            passwordTextField.returnKeyType = .go
        
        } else {
            loginButton.isEnabled = false
            emailTextField.returnKeyType = .next
            passwordTextField.returnKeyType = .next
        }
        
        emailTextField.reloadInputViews()
        passwordTextField.reloadInputViews()
    }
    
    private func areBothFieldsFilledIn() -> Bool {
        if let email = emailTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces), !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty {
            return true
        }
        
        return false
    }
}
