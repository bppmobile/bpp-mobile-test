import Foundation

extension URLRequest {
    static func JSONRequest(url: URL,
                            cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData,
                            timeoutInterval: TimeInterval = 10) -> URLRequest {
        
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
