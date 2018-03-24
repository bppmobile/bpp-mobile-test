import Foundation

enum LoginError: Error {
    case invalidFormattedEmail
    case invalidEmailOrPassword
    
    var localizedDescription: String {
        switch self {
        case .invalidFormattedEmail:
            return Localization.loginErrorInvalidFormattedEmail
            
        case .invalidEmailOrPassword:
            return Localization.loginErrorInvalidEmailOrPasswordMessage
        }
    }
}

extension Error {
    var asLoginError: LoginError? {
        return self as? LoginError
    }
}
