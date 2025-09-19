import Foundation
import Entities

public struct Room: Sendable, Hashable, Equatable, Identifiable {
    public var id: Entities.Room.ID
    public var name: String
    public var type: RoomType
    public var role: Entities.Room.Role?
    public var sticky: Bool
    public var unreadNum: Int
    public var mentionNum: Int
    public var iconPath: String
    public var lastUpdateTime: TimeInterval
    public var description: String?

    public init(
        id: Entities.Room.ID,
        name: String,
        type: RoomType,
        role: Entities.Room.Role?,
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
    }
}

extension Room: Codable {

    enum CodingKeys: String, CodingKey {
        case id = "room_id"
        case name
        case type
        case role
        case sticky
        case unreadNum = "unread_num"
        case mentionNum = "mention_num"
        case iconPath = "icon_path"
        case lastUpdateTime = "last_update_time"
        case description
    }
}
