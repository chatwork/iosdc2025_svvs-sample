import Entities
import Stores

public extension RoomMessagesStoreProtocol {
    var values: [Room.ID: [Message]] { fatalError() }
    func loadValue(for id: Room.ID) async throws { fatalError() }
    func send(_ body: String, on id: Room.ID) async throws { fatalError() }
}

public final class UnimplementedRoomMessagesStore<Dependency: DependencyProtocol>: RoomMessagesStoreProtocol {
    public init() { fatalError() }
}
