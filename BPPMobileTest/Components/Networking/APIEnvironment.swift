import Foundation

enum APIEnvironment: String {
    case development, staging, production

    var baseURL: URL {
        // Here we should have a different baseURL per environment
        
        //swiftlint:disable force_unwrapping
        switch self {
        case .development:
            return URL(string: "http://test-mobile.dev-bpp.com.br")!
            
        case .staging:
            return URL(string: "http://test-mobile.dev-bpp.com.br")!
            
        case .production:
            return URL(string: "http://test-mobile.dev-bpp.com.br")!
        }
        //swiftlint:enable force_unwrapping
    }
    
    static var current: APIEnvironment {
        guard let environmentString: String = environmentSetting(withName: "CURRENT_ENVIRONMENT"),
            let environment = APIEnvironment(rawValue: environmentString) else { return .production }
        
        return environment
    }
    
    private static func environmentSetting<T>(withName name: String) -> T? {
        guard let enviromentSetting = Bundle.main.infoDictionary?["EnviromentSetting"] as? [String: AnyObject] else { return nil }
        guard let key = enviromentSetting[name] else { return nil }
        
        return key as? T
    }
}
