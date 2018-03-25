import Foundation

final class LoginViewModel {
    
    // MARK: Init/Deinit
    
    init(emailValidator: EmailValidator, loginService: LoginService) {
        self.emailValidator = emailValidator
        self.loginService = loginService
    }
    
    // MARK: Public methods
    
    func isEmailValid(_ email: String) -> Bool {
        return emailValidator.isEmailValid(email)
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        return !password.isEmpty
    }
    
    func login(withEmail email: String, password: String, completion: @escaping (Result<LoginResponse>) -> Void) {
        do {
            let credentials = try LoginCredentials(email: email, password: password)
            
            loginService.login(withCredentials: credentials) { result in
                switch result {
                case .success(let loginResponse):
                    if loginResponse.isLoginSuccessful() {
                        completion(.success(loginResponse))
                    
                    } else {
                        let error = LoginError.invalidEmailOrPassword
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func cancelRequest() {
        loginService.cancelRequest()
    }
    
    // MARK: Private properties
    
    private let emailValidator: EmailValidator
    private let loginService: LoginService
}
