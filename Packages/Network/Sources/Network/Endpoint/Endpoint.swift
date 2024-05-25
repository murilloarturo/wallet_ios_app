import Foundation

public protocol Endpoint {
    var scheme: String { get }
    var baseURL: String { get }
    var port: Int { get }
    var path: String { get }
    var method: RequestMethod { get }
    var queryItems: [String: Any]? { get }
    var body: [String: Any]? { get }
    var headers: [String: String]? { get }
}

public extension Endpoint {
    var scheme: String {
        "https"
    }
    var port: Int {
        8080
    }
    var queryItems: [String: Any]? {
        nil
    }
    var body: [String: Any]? {
        nil
    }
    var headers: [String: String]? {
        nil
    }
}
