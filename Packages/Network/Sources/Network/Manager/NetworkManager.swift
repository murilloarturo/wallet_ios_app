import Foundation
import Combine

public typealias NetworkCompletion<T> = (_ response: Result<T, Error>) -> Void

public protocol NetworkClient: AnyObject {
    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping NetworkCompletion<T>)
    func asyncRequest<T: Decodable>(endpoint: Endpoint) async throws -> Result<T, Error>
    func combineRequest<T: Decodable>(endpoint: Endpoint) throws -> AnyPublisher<T, Error>
}

public class NetworkManager: NetworkClient {
    private var session: URLSession
    private var jsonDecoder: JSONDecoder
    private var loggingEnabled: Bool
    private var timeout: Double
    
    public static func buildDefault(session: URLSession = .shared,
                             customDecoder: JSONDecoder = JSONDecoder(),
                             loggingEnabled: Bool = false,
                             timeout: Double = 10) -> Self {
        .init(session: session,
              customDecoder: customDecoder,
              loggingEnabled: loggingEnabled,
              timeout: timeout)
    }
    
    required init(session: URLSession,
                  customDecoder: JSONDecoder,
                  loggingEnabled: Bool,
                  timeout: Double) {
        self.session = session
        self.jsonDecoder = customDecoder
        self.loggingEnabled = loggingEnabled
        self.timeout = timeout
    }
    
    public func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping NetworkCompletion<T>) {
        var task: URLSessionTask?
        do {
            let request = try self.buildRequest(from: endpoint)
            task = session.dataTask(with: request) { [weak self] data, response, error in
                guard let self else { return }
                if error != nil {
                    let error = NetworkError.noConnection
                    handleLogging(error: error)
                    completion(.failure(error))
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(NetworkError.noResponse))
                    return
                }
                switch response.networkResponse {
                case .success:
                    guard let data else {
                        let error = NetworkError.noData
                        handleLogging(error: error)
                        completion(.failure(error))
                        return
                    }
                    do {
                        let jsonResponse = try jsonDecoder.decode(T.self, from: data)
                        completion(.success(jsonResponse))
                    } catch {
                        handleLogging(error: error)
                        completion(.failure(NetworkError.unableToDecode))
                    }
                    
                case .failure(let error):
                    handleLogging(error: error)
                    completion(.failure(error))
                }
            }
            
        } catch {
            handleLogging(error: error)
            completion(.failure(error))
        }
        task?.resume()
    }
    
    public func asyncRequest<T: Decodable>(endpoint: Endpoint) async throws -> Result<T, Error> {
        do {
            let request = try buildRequest(from: endpoint)
            let (data, response) = try await session.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                return .failure(NetworkError.noResponse)
            }
            switch response.networkResponse {
            case .success:
                do {
                    let jsonResponse = try jsonDecoder.decode(T.self, from: data)
                    return .success(jsonResponse)
                } catch {
                    handleLogging(error: error)
                    return .failure(NetworkError.unableToDecode)
                }
            case .failure(let error):
                handleLogging(error: error)
                return .failure(error)
            }
        } catch {
            handleLogging(error: error)
            return .failure(error as? NetworkError ?? NetworkError.noConnection)
        }
    }
    
    public func combineRequest<T: Decodable>(endpoint: Endpoint) throws -> AnyPublisher<T, Error> {
        let request = try buildRequest(from: endpoint)
        return session
            .dataTaskPublisher(for: request)
            .tryDecodeResponse(type: T.self, decoder: jsonDecoder)
            .mapError({ error in
                let networkError = error as? NetworkError ?? NetworkError.noResponse
                self.handleLogging(error: networkError)
                return networkError
            })
            .eraseToAnyPublisher()
    }
    
    private func buildRequest(from endpoint: Endpoint) throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host =  endpoint.baseURL
        urlComponents.port = endpoint.port
        urlComponents.path = endpoint.path
        var queryItems = [URLQueryItem]()
        if let queryParameters = endpoint.queryItems, !queryParameters.isEmpty {
            queryParameters.forEach({ (key, value) in
                let queryItem = URLQueryItem(name: key,
                                             value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                queryItems.append(queryItem)
            })
        }
        
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            throw NetworkError.badURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("true", forHTTPHeaderField: "X-Use-Cache")
        request.timeoutInterval = timeout
        
        if let body = endpoint.body {
            do {
                let jsonAsData = try JSONSerialization.data(withJSONObject: body,
                                                            options: .prettyPrinted)
                request.httpBody = jsonAsData
            } catch {
                throw NetworkError.unableToEncode
            }
        }
        
        return request
    }
    
    private func handleLogging(error: Error) {
        if loggingEnabled {
            print(error)
        }
    }
}

extension Publisher {
    func tryDecodeResponse<T: Decodable, Coder>(type: T.Type, decoder: Coder) -> Publishers.Decode<Publishers.TryMap<Self, Data>, T, Coder> where T: Decodable, Coder: TopLevelDecoder, Self.Output == (data: Data, response: URLResponse) {
        return self
            .tryMap { output in
                let result = output.response.http?.networkResponse ?? .failure(NetworkError.failed)
                switch result {
                case .success:
                    return output.data
                case .failure(let error):
                    throw error
                }
            }
            .decode(type: type, decoder: decoder)
    }
}

extension HTTPURLResponse {
    var networkResponse: NetworkResponse {
        switch statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkError.authentication)
        case 501...599: return .failure(NetworkError.badRequest)
        case 600: return .failure(NetworkError.outdated)
        default: return .failure(NetworkError.failed)
        }
    }
}

extension URLResponse {
    var http: HTTPURLResponse? {
        return self as? HTTPURLResponse
    }
}
