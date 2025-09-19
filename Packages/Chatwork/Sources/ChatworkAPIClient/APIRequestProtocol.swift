import Foundation

public enum HTTPMethod: String, Sendable {
    case get = "GET"
    case post = "POST"
}

public enum HeaderType: Sendable {
    case getJson
    case postURLEncoded

    var contentType: String? {
        switch self {
        case .getJson:
            return nil
        case .postURLEncoded:
            return "application/x-www-form-urlencoded"
        }
    }
}

public protocol APIRequestProtocol: Sendable {
    associatedtype Response: Sendable & Decodable
    var path: String { get }
    var method: HTTPMethod { get }
    var headerType: HeaderType { get }
    var httpBody: Data? { get }
    var queryItems: [URLQueryItem]? { get }
}
