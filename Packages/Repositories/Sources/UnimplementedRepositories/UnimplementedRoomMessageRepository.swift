import Entities
import Repositories

public extension RoomMessagesRepositoryProtocol {
    init(login: Login) { fatalError() }
    func fetchValue(for id: Room.ID) async throws -> [(message: Message, account: Message.Account)] { fatalError() }
    func sendMessage(roomID: Room.ID, body: String) async throws { fatalError() }
}

public struct UnimplementedRoomMessagesRepository: RoomMessagesRepositoryProtocol {}
