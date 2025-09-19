import Entities
import Repositories

public extension LoginRepositoryProtocol {
    static func localLogins() async -> [Login] { fatalError() }
    static func removeLocalLogin(with id: Login.ID) async { fatalError() }
    static func logIn(with apiToken: APIToken) async throws -> Account { fatalError() }
}

public enum UnimplementedLoginRepository: LoginRepositoryProtocol {}
