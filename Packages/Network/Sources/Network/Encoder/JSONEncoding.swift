import Foundation

public struct JSONEncoding {
    public func encode(parameters: [String: Any]?) throws -> Data? {
        guard let parameters = parameters else { return nil }
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters,
                                                        options: .prettyPrinted)
            return jsonAsData
        } catch {
            throw NetworkError.unableToEncode
        }
    }
}
