import Entities

public protocol RoomMessagesRepositoryProtocol: Sendable {
    init(login: Login)
    func fetchValue(for id: Entities.Room.ID) async throws -> [(message: Entities.Message, account: Entities.Message.Account)]
    func sendMessage(roomID: Entities.Room.ID, body: String) async throws
}
