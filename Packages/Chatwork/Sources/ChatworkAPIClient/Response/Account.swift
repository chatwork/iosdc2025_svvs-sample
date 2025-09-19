import Entities
import struct Foundation.Date

public struct Account: Sendable, Hashable, Equatable, Identifiable {
    public let id: Entities.Account.ID
    public var name: String
    public var avatarImageURL: String

    public var chatworkID: String?
    public var loginMail: String?

    public init(
        id: Entities.Account.ID,
        name: String,
        avatarImageURL: String,
        chatworkID: String?,
        loginMail: String?
    ) {
        self.id = id
        self.name = name
        self.avatarImageURL = avatarImageURL
        self.chatworkID = chatworkID
        self.loginMail = loginMail
    }
}

extension Account: Codable {
    public enum CodingKeys: String, CodingKey {
        case id = "account_id"
        case name
        case avatarImageURL = "avatar_image_url"
        case chatworkID = "chatwork_id"
        case loginMail = "login_mail"
    }
}

