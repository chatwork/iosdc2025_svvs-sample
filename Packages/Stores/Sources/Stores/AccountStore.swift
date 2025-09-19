import Entities
import Observation
import Repositories

@MainActor
@Observable
public final class AccountStore<Dependency: DependencyProtocol>: AccountStoreProtocol {
    public typealias LoginContext = Stores.LoginContext<Dependency>
    public typealias ID = Account.ID
    public typealias Value = Account

    private weak var loginContext: LoginContext!

    public private(set) var values: [Account.ID: Account]

    let meID: Account.ID

    public init(me: Account) {
        self.meID = me.id
        self.values = [me.id: me]
    }

    public var me: Account {
        values[meID]!
    }

    public func _configure(with loginContext: LoginContext) {
        self.loginContext = loginContext
    }

    public func loadMe() async throws {
        let me = try await loginContext.meRepository.fetchValue()
        update(me)
    }

    public func update(_ account: Account) {
        values[account.id] = account
    }

    public func update(_ value: Message.Account) {
        var account = values[value.id, default: Account(value)]
        account.name = value.name
        account.avatarImageURL = value.avatarImageURL
        values[value.id] = account
    }
}
