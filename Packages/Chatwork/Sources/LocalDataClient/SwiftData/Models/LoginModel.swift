import Entities
import struct Foundation.Date
import SwiftData

@Model
final class LoginModel {
    @Attribute(.unique) var id: Int
    var account: Account
    var loggedInAt: Date

    init(account: Account, loggedInAt: Date) {
        self.id = account.id.rawValue
        self.account = account
        self.loggedInAt = loggedInAt
    }
}

extension LoginModel: EntityConvertible {
    struct Entity: Identifiable, Sendable, Hashable, Codable {
        var id: Account.ID { account.id }
        var account: Account
        var loggedInAt: Date
        init(account: Account, loggedInAt: Date) {
            self.account = account
            self.loggedInAt = loggedInAt
        }
    }
    convenience init(from entity: Entity) {
        self.init(account: entity.account, loggedInAt: entity.loggedInAt)
    }
    func entity() -> Entity {
        .init(account: account, loggedInAt: loggedInAt)
    }
    func update(from entity: Entity) {
        self.account = entity.account
        self.loggedInAt = entity.loggedInAt
    }
}
