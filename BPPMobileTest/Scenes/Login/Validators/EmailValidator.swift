import Foundation

final class EmailValidator {
    
    // MARK: Public methods
    
    func isEmailValid(_ email: String) -> Bool {
        // Trying to validate an email address any more than just checking if it has an "@"
        // is likely to lead to wrong results. Email addresses can be really, really complicated.
        // It's best to just send an activation email.
        // See: https://hackernoon.com/the-100-correct-way-to-validate-email-addresses-7c4818f24643
        
        let trimmedEmail = email.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        guard !trimmedEmail.isEmpty, trimmedEmail.contains("@") else { return false }
        
        return true
    }
}
