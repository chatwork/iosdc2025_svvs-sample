import ChatworkAPIClient
import Entities
import Foundation
import Repositories

public struct RoomMessagesRepository<Dependency: DependencyProtocol>: RoomMessagesRepositoryProtocol {

    private let apiClient: APIClient

    public init(login: Login) {
        self.apiClient = APIClient(
            apiToken: login.apiToken.rawValue,
            baseURL: Dependency.baseURL
        )
    }

    public func fetchValue(for id: Entities.Room.ID) async throws -> [(message: Entities.Message, account: Entities.Message.Account)] {
        let request = MessagesRequest(roomID: id.rawValue)

        do {
            let responses = try await apiClient.send(request)
            return responses.map { response in
                let message = Entities.Message(
                    id: response.id,
                    accountID: response.account.id,
                    body: response.body,
                    sendTime: response.sendTime,
                    updateTime: response.updateTime
                )
                let account = Entities.Message.Account(
                    id: response.account.id,
                    name: response.account.name,
                    avatarImageURL: response.account.avatarImageURL
                )
                return (message: message, account: account)
            }
        } catch APIError.emptyResponse {
            return []
        } catch {
            throw error
        }
    }

    public func sendMessage(roomID: Entities.Room.ID, body: String) async throws {
        let request = PostMessageRequest(roomID: roomID.rawValue, body: body)
        let _ = try await apiClient.send(request)
    }
}
