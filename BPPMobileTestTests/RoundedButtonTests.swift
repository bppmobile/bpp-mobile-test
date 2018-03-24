@testable import BPPMobileTest
import XCTest

final class RoundedButtonTests: XCTestCase {
    
    func testChangingButtonToLoadingStateThenToIdleState() {
        let button = RoundedButton()
        
        let title = "Rounded Button Title"
        button.setTitle(title, for: .normal)
        
        button.viewState = .isLoading
        XCTAssertNil(button.title(for: .normal))
        XCTAssert(button.isUserInteractionEnabled == false)
        
        button.viewState = .idle
        XCTAssert(button.title(for: .normal) == title)
        XCTAssert(button.isUserInteractionEnabled == true)
    }
    
    func testChangingButtonToLoadingStateThenToErrorState() {
        let button = RoundedButton()
        
        let title = "Rounded Button Title"
        button.setTitle(title, for: .normal)
        
        button.viewState = .isLoading
        XCTAssertNil(button.title(for: .normal))
        XCTAssert(button.isUserInteractionEnabled == false)
        
        let error = LoginError.emailOrPasswordInvalid
        
        button.viewState = .hasError(error)
        XCTAssert(button.title(for: .normal) == title)
        XCTAssert(button.isUserInteractionEnabled == true)
    }
    
    func testChangingButtonToErrorStateThenToLoadingState() {
        let button = RoundedButton()
        
        let title = "Rounded Button Title"
        button.setTitle(title, for: .normal)
        
        let error = LoginError.emailOrPasswordInvalid
        
        button.viewState = .hasError(error)
        XCTAssert(button.title(for: .normal) == title)
        XCTAssert(button.isUserInteractionEnabled == true)
        
        button.viewState = .isLoading
        XCTAssertNil(button.title(for: .normal))
        XCTAssert(button.isUserInteractionEnabled == false)
    }
}
