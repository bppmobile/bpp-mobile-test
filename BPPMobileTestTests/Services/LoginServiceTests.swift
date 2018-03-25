import XCTest
import OHHTTPStubs
@testable import BPPMobileTest

final class LoginServiceTests: XCTestCase {
    
    override func tearDown() {
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }
    
    func testLoginServiceSuccess() {
        let email = "waldisney@dev-bpp.com.br"
        let password = "Br@silPP123"
        let status = "success"
        let code = "200"
        
        stub(condition: isHost(host) && isPath(endpoint)) { _ in
            return OHHTTPStubsResponse(
                jsonObject: ["status": status, "code": code],
                statusCode: 200,
                headers: .none
            )
        }
        
        let credentials: LoginCredentials
        
        do {
            credentials = try LoginCredentials(email: email, password: password)
        } catch let error {
            XCTFail(error.localizedDescription)
            return
        }
        
        let networkClient = NetworkClient()
        let loginService = LoginService(networkClient: networkClient)
        let expectation = self.expectation(description: "calls stubbed login service")
        
        loginService.login(withCredentials: credentials) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.status, status)
                XCTAssertEqual(response.code, code)
                XCTAssertTrue(response.isLoginSuccessful())
                
            case .failure(let error):
                XCTFail("Login service stubbed call failed with error \(error)")
            }
            
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLoginServiceError() {
        let email = "johnny.appleseed@dev-bpp.com.br"
        let password = "wrongpassword"
        let status = "error"
        let code = "300"
        let message = "usuario invalido"
        
        stub(condition: isHost(host) && isPath(endpoint)) { _ in
            return OHHTTPStubsResponse(
                jsonObject: ["status": status, "code": code, "message": message],
                statusCode: 200,
                headers: .none
            )
        }
        
        let credentials: LoginCredentials
        
        do {
            credentials = try LoginCredentials(email: email, password: password)
        } catch let error {
            XCTFail(error.localizedDescription)
            return
        }
        
        let networkClient = NetworkClient()
        let loginService = LoginService(networkClient: networkClient)
        let expectation = self.expectation(description: "calls stubbed login service")
        
        loginService.login(withCredentials: credentials) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.status, status)
                XCTAssertEqual(response.code, code)
                XCTAssertEqual(response.message, message)
                XCTAssertFalse(response.isLoginSuccessful())
                
            case .failure(let error):
                XCTFail("Login service stubbed call failed with error \(error)")
            }
            
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 1, handler: nil)
        OHHTTPStubs.removeAllStubs()
    }
    
    private let host = "test-mobile.dev-bpp.com.br"
    private let endpoint = "/login"
}
