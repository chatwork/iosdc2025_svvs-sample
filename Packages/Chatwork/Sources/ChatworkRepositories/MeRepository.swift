import ChatworkAPIClient
import Entities
import Foundation
import Repositories

public struct MeRepository<Dependency: DependencyProtocol>: MeRepositoryProtocol {

    private let apiClient: APIClient

    public init(login: Login) {
        self.apiClient = APIClient(
            apiToken: login.apiToken.rawValue,
            baseURL: Dependency.baseURL
        )
    }

    public func fetchValue() async throws -> Entities.Account {
        let request = MeRequest()
        let response = try await apiClient.send(request)
        return Entities.Account(from: response)
    }
}

extension Entities.Account {
    init(from response: ChatworkAPIClient.Account) {
        self.init(
            id: response.id,
            name: response.name,
            avatarImageURL: response.avatarImageURL,
            chatworkID: response.chatworkID,
            loginMail: response.loginMail
        )
    }
}
