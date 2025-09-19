import struct Foundation.TimeInterval

public struct Message: Identifiable, Hashable, Sendable, Codable {
    public struct ID: Hashable, Sendable, Codable, RawRepresentable, ExpressibleByStringLiteral {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        public init(stringLiteral value: StringLiteralType) {
            self.rawValue = value
        }
    }
    public let id: ID
    public let accountID: Entities.Account.ID
    public let body: String
    public let sendTime: TimeInterval
    public let updateTime: TimeInterval

    
    public init(
        id: ID,
        accountID: Entities.Account.ID,
        body: String,
        sendTime: TimeInterval,
        updateTime: TimeInterval
    ) {
        self.id = id
        self.accountID = accountID
        self.body = body
        self.sendTime = sendTime
        self.updateTime = updateTime
    }
}

extension Message {
    public struct Account: Sendable, Equatable, Identifiable, Codable {
        public var id: Entities.Account.ID
        public var name: String
        public var avatarImageURL: String
        public init(id: Entities.Account.ID, name: String, avatarImageURL: String) {
            self.id = id
            self.name = name
            self.avatarImageURL = avatarImageURL
        }
    }
}
