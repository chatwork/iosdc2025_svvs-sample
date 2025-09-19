import Entities
import Observation

@MainActor
public protocol AccountStoreProtocol<Dependency>: Observable, LoginScoped {
    var values: [Account.ID: Account] { get }
    var me: Account { get }
    func loadMe() async throws
    func update(_ account: Account)
    func update(_ value: Message.Account)

    init(me: Account)
}
