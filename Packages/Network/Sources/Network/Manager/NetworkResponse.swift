import Foundation

public enum NetworkResponse {
    case success
    case failure(NetworkError)
}

public enum NetworkError: Error {
    case noConnection
    case failed
    case authentication
    case badRequest
    case outdated
    case noData
    case noResponse
    case unableToDecode
    case unableToEncode
    case badURL
    case unableToDownloadFile
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noConnection:
            return "No connection"
            
        case .failed:
            return "Request failed"
            
        case .authentication:
            return "Authentication failed"
            
        case .badRequest:
            return "Bad request"
        
        case .outdated:
            return "Outdated request"
            
        case .noData:
            return "No data"
            
        case .noResponse:
            return "No response"
            
        case .unableToDecode:
            return "Unable to decode data"
            
        case .unableToEncode:
            return "Unable to encode parameters"
            
        case .badURL:
            return "Unable to generate URL"
            
        case .unableToDownloadFile:
            return "Unable to download file"
        }
    }
}
