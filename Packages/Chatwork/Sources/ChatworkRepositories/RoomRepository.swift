import ChatworkAPIClient
import Entities
import Foundation
import Repositories

public struct RoomRepository<Dependency: DependencyProtocol>: RoomRepositoryProtocol {

    private let apiClient: APIClient

    public init(login: Login) {
        self.apiClient = APIClient(
            apiToken: login.apiToken.rawValue,
            baseURL: Dependency.baseURL
        )
    }

    public func fetchValues() async throws -> [Entities.Room] {
        let request = RoomsRequest()
        let responses = try await apiClient.send(request)
        return responses.map { Entities.Room(from: $0) }
    }

    public func fetchValue(for roomID: Entities.Room.ID) async throws -> Entities.Room {
        let request = RoomRequest(roomID: roomID.rawValue)
        let response = try await apiClient.send(request)
        return Entities.Room(from: response)
    }
}

extension Entities.Room {
    init(from response: ChatworkAPIClient.Room) {
        self.init(
            id: response.id,
            name: response.name,
            type: response.type,
            role: response.role,
            sticky: response.sticky,
            unreadNum: response.unreadNum,
            mentionNum: response.mentionNum,
            iconPath: response.iconPath,
            lastUpdateTime: response.lastUpdateTime,
            description: response.description
        )
    }
}
