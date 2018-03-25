import UIKit

enum HTTPMethod: String {
    case get = "GET", post = "POST", put = "PUT", delete = "DELETE"
}

enum NetworkError: Error {
    case httpError(Error), noData, invalidJSON
}

struct Resource<T> {
    let request: URLRequest
    let parse: (Data) -> T?
}

protocol Networking {
    func load<T>(_ resource: Resource<T>, completion: @escaping (Result<T>) -> Void)
    func cancelInflightRequest()
}

final class NetworkClient: Networking {
    // MARK: Init/Deinit

    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.configuration = configuration
        self.session = URLSession(configuration: configuration)
    }

    deinit {
        cancelInflightRequest()
    }

    // MARK: Public methods

    func load<T>(_ resource: Resource<T>, completion: @escaping (Result<T>) -> Void) {
        dataTask = session.dataTask(with: resource.request) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.disableNetworkActivityIndicator()
                    let httpError = NetworkError.httpError(error)
                    let result: Result<T> = Result.failure(httpError)
                    completion(result)
                }

                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.disableNetworkActivityIndicator()
                    let result: Result<T> = Result.failure(NetworkError.noData)
                    completion(result)
                }

                return
            }

            guard let parsedResource = resource.parse(data) else {
                DispatchQueue.main.async {
                    self.disableNetworkActivityIndicator()
                    let result: Result<T> = Result.failure(NetworkError.invalidJSON)
                    completion(result)
                }

                return
            }

            DispatchQueue.main.async {
                self.disableNetworkActivityIndicator()
                let result: Result<T> = Result.success(parsedResource)
                completion(result)
            }
        }

        enableNetworkActivityIndicator()
        dataTask?.resume()
    }

    func cancelInflightRequest() {
        disableNetworkActivityIndicator()
        dataTask?.cancel()
    }

    // MARK: Private properties

    private let configuration: URLSessionConfiguration
    private let session: URLSession
    private var dataTask: URLSessionDataTask?

    // MARK: Private methods

    private func enableNetworkActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    private func disableNetworkActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
