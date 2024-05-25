import Foundation

public protocol Endpoint {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var queryItems: [String: Any]? { get }
    var body: [String: Any]? { get }
    var headers: [String: String]? { get }
}
