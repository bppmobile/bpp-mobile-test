import XCTest
@testable import BPPMobileTest

final class EmailValidatorTests: XCTestCase {
    
    func testValidateAValidEmail() {
        let email = "johnny.appleseed@apple.com"
        let validator = EmailValidator()
        
        XCTAssertTrue(validator.isEmailValid(email))
    }
    
    func testValidateAValidEmailWithWhitespaces() {
        let email = "   johnny.appleseed@apple.com "
        let validator = EmailValidator()
        
        XCTAssertTrue(validator.isEmailValid(email))
    }
    
    func testValidateAnInvalidEmail() {
        let email = "johnny.appleseed"
        let validator = EmailValidator()
        
        XCTAssertFalse(validator.isEmailValid(email))
    }
}
