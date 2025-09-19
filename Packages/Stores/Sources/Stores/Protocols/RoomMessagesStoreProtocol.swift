import Entities
import Observation

@MainActor
public protocol RoomMessagesStoreProtocol<Dependency>: Observable, LoginScoped {
    var values: [Room.ID: [Message]] { get }
    func loadValue(for id: Room.ID) async throws
    func send(_ body: String, on id: Room.ID) async throws

    init()
}
