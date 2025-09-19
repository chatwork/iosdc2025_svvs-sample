import Entities
import Observation
import Repositories

@MainActor
@Observable
public final class RoomMessagesStore<Dependency: DependencyProtocol>: RoomMessagesStoreProtocol {
    public typealias LoginContext = Stores.LoginContext<Dependency>
    public typealias ID = Room.ID
    public typealias Value = [Message]

    private weak var loginContext: LoginContext!

    public private(set) var values: [ID: Value] = [:]

    public init() {}

    public func _configure(with loginContext: LoginContext) {
        self.loginContext = loginContext
    }

    public func loadValue(for id: ID) async throws {
        let messageResponses = try await loginContext.roomMessagesRepository.fetchValue(for: id)
        var messages: [Message] = []
        for response in messageResponses {
            messages.append(response.message)
            loginContext.accountStore.update(response.account)
        }
        values[id] = messages
    }

    public func send(_ body: String, on id: ID) async throws {
        try await loginContext.roomMessagesRepository.sendMessage(roomID: id, body: body)
        try await loadValue(for: id)
    }
}
