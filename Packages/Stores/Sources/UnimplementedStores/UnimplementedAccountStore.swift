import Entities
import Stores

public extension AccountStoreProtocol {
    var values: [Account.ID: Account] { fatalError() }
    var me: Account { fatalError() }
    func loadMe() async throws { fatalError() }
    func update(_ account: Account) { fatalError() }
    func update(_ value: Message.Account) { fatalError() }
}

public final class UnimplementedAccountStore<Dependency: DependencyProtocol>: AccountStoreProtocol {
    public init(me: Entities.Account) { fatalError() }
}
