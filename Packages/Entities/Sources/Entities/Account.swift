import struct Foundation.Date

public struct Account: Hashable, Sendable, Equatable, Identifiable, Codable {
    public struct ID: Hashable, Equatable, Sendable, Codable, RawRepresentable, ExpressibleByIntegerLiteral {
        public var rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        public init(integerLiteral value: IntegerLiteralType) {
            self.rawValue = value
        }
    }

    public let id: ID
    public var name: String
    public var avatarImageURL: String

    public var chatworkID: String?
    public var loginMail: String?

    public init(
        id: ID,
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

extension Account {
    public init(_ partial: Message.Account) {
        self.id = partial.id
        self.name = partial.name
        self.avatarImageURL = partial.avatarImageURL
        self.chatworkID = nil
        self.loginMail = nil
    }
}
