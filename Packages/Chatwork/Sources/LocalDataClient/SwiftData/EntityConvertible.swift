import Entities
import SwiftData

protocol EntityConvertible where Self: PersistentModel, Entity.ID: RawRepresentable, ID == Entity.ID.RawValue {
    associatedtype Entity: Identifiable & Sendable & Hashable & Codable
    init (from entity: Entity)
    func update(from entity: Entity)
    func entity() -> Entity
}
