import Foundation

final class LoginService {
    
    // MARK: Init/Deinit
    
    init(networkClient: Networking) {
        self.networkClient = networkClient
    }
    
    deinit {
        networkClient.cancelInflightRequest()
    }
    
    // MARK: Public methods
    
    func login(withCredentials credentials: LoginCredentials, completion: @escaping (Result<LoginResponse>) -> Void) {
        let resource = createResource(from: credentials)
        networkClient.load(resource, completion: completion)
    }
    
    func cancelRequest() {
        networkClient.cancelInflightRequest()
    }
    
    // MARK: Private properties
    
    private let networkClient: Networking
    private let endpoint = "login"
    
    private var url: URL {
        let baseURL = APIEnvironment.current.baseURL
        let url = baseURL.appendingPathComponent(endpoint)
        return url
    }
    
    // MARK: Private methods
    
    private func createResource(from credentials: LoginCredentials) -> Resource<LoginResponse> {
        var request = URLRequest.JSONRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(credentials)
        
        let resource = Resource(request: request) { data -> LoginResponse? in
            let decoder = JSONDecoder()
            return try? decoder.decode(LoginResponse.self, from: data)
        }
        
        return resource
    }
}
