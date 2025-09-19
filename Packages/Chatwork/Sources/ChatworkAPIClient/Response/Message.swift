import Entities
import Foundation

public struct Message: Sendable, Hashable, Equatable, Identifiable {
    public let id: Entities.Message.ID
    public var account: Account
    public var body: String
    public var sendTime: TimeInterval
    public var updateTime: TimeInterval

    public struct Account: Sendable, Hashable, Equatable, Identifiable {
        public let id: Entities.Account.ID
        public var name: String
        public var avatarImageURL: String

        public init(id: Entities.Account.ID, name: String, avatarImageURL: String) {
            self.id = id
            self.name = name
            self.avatarImageURL = avatarImageURL
        }
    }

    public init(
        id: Entities.Message.ID,
        account: Account,
        body: String,
        sendTime: TimeInterval,
        updateTime: TimeInterval
    ) {
        self.id = id
        self.account = account
        self.body = body
        self.sendTime = sendTime
        self.updateTime = updateTime
    }
}

extension Message: Codable {
    
    public enum CodingKeys: String, CodingKey {
        case id = "message_id"
        case account
        case body
        case sendTime = "send_time"
        case updateTime = "update_time"
    }
}

extension Message.Account: Codable {
    public enum CodingKeys: String, CodingKey {
        case id = "account_id"
        case name
        case avatarImageURL = "avatar_image_url"
    }
}
