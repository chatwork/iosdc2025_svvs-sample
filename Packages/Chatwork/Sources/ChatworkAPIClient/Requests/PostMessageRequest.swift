import Entities
import Foundation

/// メッセージ投稿
public struct PostMessageRequest: APIRequestProtocol {
    public struct Response: Sendable, Codable {
        public enum CodingKeys: String, CodingKey {
            case messageID = "message_id"
        }
        public let messageID: Entities.Message.ID
    }

    public let path: String
    public let headerType: HeaderType = .postURLEncoded
    public let method: HTTPMethod = .post
    public let httpBody: Data?
    public let queryItems: [URLQueryItem]? = nil

    public init(roomID: Int, body: String) {
        path = "/rooms/\(roomID)/messages"
        let postData = "self_unread=0&body=\(body)".data(using: .utf8)
        httpBody = postData
    }
}
