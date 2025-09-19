import Entities
import Stores

public extension RoomStoreProtocol {
    var values: [Room] { fatalError() }
    func loadValue() async { fatalError() }
}

public final class UnimplementedRoomStore<Dependency: DependencyProtocol>: RoomStoreProtocol {
    public init() { fatalError() }
}
