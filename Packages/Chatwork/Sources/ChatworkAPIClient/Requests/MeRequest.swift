import Entities
import Foundation

/// Me(Account) 情報取得
public struct MeRequest: APIRequestProtocol {
    public typealias Response = Account

    public let path: String = "/me"
    public let headerType: HeaderType = .getJson
    public let method: HTTPMethod = .get
    public let httpBody: Data? = nil
    public let queryItems: [URLQueryItem]? = nil
    
    public init() {}
}
