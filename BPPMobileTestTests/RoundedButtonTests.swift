@testable import BPPMobileTest
import XCTest

final class RoundedButtonTests: XCTestCase {
    
    func testChangingButtonToLoadingStateThenToIdleState() {
        let button = RoundedButton()
        
        let title = "Rounded Button Title"
        button.setTitle(title, for: .normal)
        
        button.viewState = .isLoading
        XCTAssertNil(button.title(for: .normal))
        XCTAssertFalse(button.isUserInteractionEnabled)
        
        button.viewState = .idle
        XCTAssert(button.title(for: .normal) == title)
        XCTAssertTrue(button.isUserInteractionEnabled)
    }
    
    func testChangingButtonToLoadingStateThenToErrorState() {
        let button = RoundedButton()
        
        let title = "Rounded Button Title"
        button.setTitle(title, for: .normal)
        
        button.viewState = .isLoading
        XCTAssertNil(button.title(for: .normal))
        XCTAssertFalse(button.isUserInteractionEnabled)
        
        let error = LoginError.invalidEmailOrPassword
        
        button.viewState = .hasError(error)
        XCTAssert(button.title(for: .normal) == title)
        XCTAssertTrue(button.isUserInteractionEnabled)
    }
    
    func testChangingButtonToErrorStateThenToLoadingState() {
        let button = RoundedButton()
        
        let title = "Rounded Button Title"
        button.setTitle(title, for: .normal)
        
        let error = LoginError.invalidEmailOrPassword
        
        button.viewState = .hasError(error)
        XCTAssert(button.title(for: .normal) == title)
        XCTAssertTrue(button.isUserInteractionEnabled)
        
        button.viewState = .isLoading
        XCTAssertNil(button.title(for: .normal))
        XCTAssertFalse(button.isUserInteractionEnabled)
    }
}
