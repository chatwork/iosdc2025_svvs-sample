import Entities
import Repositories

public extension RoomRepositoryProtocol {
    init(login: Login) { fatalError() }
    func fetchValues() async throws -> [Room] { fatalError() }
    func fetchValue(for roomID: Room.ID) async throws -> Room { fatalError() }
}

public struct UnimplementedRoomRepository: RoomRepositoryProtocol {}
