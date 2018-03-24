import Foundation

enum LoginError: Error {
    case emailOrPasswordInvalid
    
    var localizedDescription: String {
        switch self {
        case .emailOrPasswordInvalid:
            return Localization.loginErrorInvalidEmailOrPasswordMessage
        }
    }
}

extension Error {
    var asLoginError: LoginError? {
        return self as? LoginError
    }
}
