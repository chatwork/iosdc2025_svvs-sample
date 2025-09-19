import Entities

public protocol MeRepositoryProtocol: Sendable {
    init(login: Login)
    func fetchValue() async throws -> Entities.Account
}
