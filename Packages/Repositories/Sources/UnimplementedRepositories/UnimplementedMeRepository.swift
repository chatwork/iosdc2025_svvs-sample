import Entities
import Repositories

public extension MeRepositoryProtocol {
    init(login: Login) { fatalError() }
    func fetchValue() async throws -> Account { fatalError() }
}

public struct UnimplementedMeRepository: MeRepositoryProtocol {}
