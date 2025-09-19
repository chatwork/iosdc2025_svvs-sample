import Foundation

/// チャットルーム一覧取得
public struct RoomRequest: APIRequestProtocol {
    public typealias Response = Room
    public let path: String
    public let headerType: HeaderType = .getJson
    public let method: HTTPMethod = .get
    public let httpBody: Data? = nil
    public let queryItems: [URLQueryItem]? = nil

    public init(roomID: Int) {
        self.path = "/rooms/\(roomID)"
    }
}
