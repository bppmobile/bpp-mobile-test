import Foundation

struct LoginResponse: Decodable {
    // MARK: Types
    
    enum Status: String {
        case success, error
    }
    
    enum Code: String {
        case success = "200", error = "300"
    }
    
    // MARK: Public methods
    
    let status: String
    let message: String?
    let code: String
    
    // MARK: Public methods
    
    func isLoginSuccessful() -> Bool {
        guard let _status = Status(rawValue: status), _status == .success else {
            return false
        }
        
        guard let _code = Code(rawValue: code), _code == .success else {
            return false
        }
        
        return true
    }
}
