import Entities

public protocol RoomRepositoryProtocol: Sendable {
    init(login: Login)
    func fetchValues() async throws -> [Entities.Room]
    func fetchValue(for roomID: Entities.Room.ID) async throws -> Entities.Room
}
