import Entities
import Observation
import Repositories

@MainActor
@Observable
public final class RoomStore<Dependency: DependencyProtocol>: RoomStoreProtocol {
    public typealias LoginContext = Stores.LoginContext<Dependency>

    public private(set) var values: [Room] = []

    public weak var loginContext: LoginContext!

    public init() {}

    public func _configure(with loginContext: LoginContext) {
        self.loginContext = loginContext
    }

    public func loadValue() async throws {
        values = try await loginContext.roomRepository.fetchValues()
    }
}
