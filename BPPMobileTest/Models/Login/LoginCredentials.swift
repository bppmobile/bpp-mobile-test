import Foundation

struct LoginCredentials: Encodable {
    // MARK: Public properties
    
    let email: String
    let password: String
    
    // MARK: Init/Deinit
    
    init(email: String, password: String) throws {
        self.email = email.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        guard let passwordData = password.data(using: .utf8) else {
            throw LoginError.unableToEncodePasswordToBase64
        }
        
        self.password = passwordData.base64EncodedString()
    }
}
