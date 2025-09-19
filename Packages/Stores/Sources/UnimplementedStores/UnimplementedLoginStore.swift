import Entities
import Stores

public extension LoginStoreProtocol {
    var values: [Login] { fatalError() }
    var currentLogin: Login? { fatalError() }
    func logIn(apiToken: APIToken) async throws { fatalError() }
    func logIn(with id: Login.ID) async throws { fatalError() }
    func logInAutomatically() async { fatalError() }
    func logOut() async { fatalError() }
}

public final class UnimplementedLoginStore: LoginStoreProtocol {
    public init() { fatalError() }
}
