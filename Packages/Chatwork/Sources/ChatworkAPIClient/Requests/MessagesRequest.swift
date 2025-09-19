import Entities
import Foundation

/// メッセージ一覧取得
public struct MessagesRequest: APIRequestProtocol {
    public typealias Response = [Message]

    public let path: String
    public let headerType: HeaderType = .getJson
    public let method: HTTPMethod = .get
    public let httpBody: Data? = nil
    public let queryItems: [URLQueryItem]?
    
    public init(roomID: Int) {
        path = "/rooms/\(roomID)/messages"
        queryItems = [.init(name: "force", value: "1")]
    }
}
