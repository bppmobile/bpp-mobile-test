import Foundation

enum LoginError: Error {
    case emptyEmailOrPassword
    case invalidFormattedEmail
    case invalidEmailOrPassword
    case unableToEncodePasswordToBase64
    
    var localizedDescription: String {
        switch self {
        case .emptyEmailOrPassword:
            return Localization.loginErrorEmptyEmailOrPassword
            
        case .invalidFormattedEmail:
            return Localization.loginErrorInvalidFormattedEmail
            
        case .invalidEmailOrPassword:
            return Localization.loginErrorInvalidEmailOrPasswordMessage
            
        case .unableToEncodePasswordToBase64:
            return Localization.loginErrorUnableToEncodePasswordToBase64
        }
    }
}

extension Error {
    var asLoginError: LoginError? {
        return self as? LoginError
    }
}
