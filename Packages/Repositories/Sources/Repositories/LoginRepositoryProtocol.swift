import Entities

public protocol LoginRepositoryProtocol: Sendable {
    static func localLogins() async -> [Login]
    static func removeLocalLogin(with id: Login.ID) async
    static func logIn(with apiToken: APIToken) async throws -> Entities.Account
}
