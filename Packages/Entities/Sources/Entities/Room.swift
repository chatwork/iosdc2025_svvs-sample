import struct Foundation.TimeInterval

public struct Room: Identifiable, Hashable, Sendable, Codable {
    public struct ID: Hashable, Codable, RawRepresentable, Sendable, ExpressibleByIntegerLiteral {
        public var rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        public init(integerLiteral value: IntegerLiteralType) {
            self.rawValue = value
        }
    }

    public enum Role: String, Codable, CaseIterable, Hashable, Sendable {
        case admin
        case member
        case readonly
    }

    public var id: ID
    public var name: String
    public var type: RoomType
    public var role: Role?
    public var sticky: Bool
    public var unreadNum: Int
    public var mentionNum: Int
    public var iconPath: String
    public var lastUpdateTime: TimeInterval
    public var description: String?

    public init(
        id: ID,
        name: String,
        type: RoomType,
        role: Role?,
        sticky: Bool,
        unreadNum: Int,
        mentionNum: Int,
        iconPath: String,
        lastUpdateTime: TimeInterval,
        description: String?
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.role = role
        self.sticky = sticky
        self.unreadNum = unreadNum
        self.mentionNum = mentionNum
        self.iconPath = iconPath
        self.lastUpdateTime = lastUpdateTime
        self.description = description
    }

    public var hasSendPermission: Bool {
        switch role {
        case .admin, .member: true
        case .readonly, .none: false
        }
    }
}
