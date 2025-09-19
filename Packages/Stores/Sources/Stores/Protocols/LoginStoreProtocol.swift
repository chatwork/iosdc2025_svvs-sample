import Entities
import Observation

@MainActor
public protocol LoginStoreProtocol: Observable {
    var values: [Login] { get }
    var currentLogin: Login? { get }
    func logIn(apiToken: APIToken) async throws
    func logIn(with id: Login.ID) async throws
    func logInAutomatically() async
    func logOut() async

    init()
}
