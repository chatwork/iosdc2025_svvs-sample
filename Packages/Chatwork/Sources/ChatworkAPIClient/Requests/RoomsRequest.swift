import Foundation

/// チャットルーム一覧取得
public struct RoomsRequest: APIRequestProtocol {
    public typealias Response = [Room]
    public let path: String = "/rooms"
    public let headerType: HeaderType = .getJson
    public let method: HTTPMethod = .get
    public let httpBody: Data? = nil
    public let queryItems: [URLQueryItem]? = nil
    
    public init() {}
}
