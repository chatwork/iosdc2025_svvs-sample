import Entities
import Observation
import Stores

@MainActor
@Observable
public final class RoomListViewState<Dependency: DependencyProtocol> {

    public typealias LoginContext = Stores.LoginContext<Dependency>

    public let roomStore: Dependency.RoomStore
    public var isFirstRefresh = true

    public init(loginContext: LoginContext) {
        self.roomStore = loginContext.roomStore
    }
    
    public var rooms: [Room] {
        roomStore.values.sorted { $0.lastUpdateTime > $1.lastUpdateTime }
    }
    
    public var selectedRoom: Room?

    public func refresh() async {
        do {
            try await roomStore.loadValue()
        } catch {
            print("Failed to load rooms: \(error)")
        }
    }

    public func task() async {
        guard isFirstRefresh else { return }
        defer { isFirstRefresh = false }
        await refresh()
    }

    public func onTapRoomRow(_ room: Room) {
        selectedRoom = room
    }
}
