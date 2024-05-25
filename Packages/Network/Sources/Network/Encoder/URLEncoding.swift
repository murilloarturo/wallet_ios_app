import Foundation

public struct URLEncoding {
    public func encode(parameters: [String: Any]?) -> [URLQueryItem] {
        guard let parameters else { return [] }
        var queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key,
                                         value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
            queryItems.append(queryItem)
        }
        return queryItems
    }
}
