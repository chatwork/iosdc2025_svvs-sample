import Entities
import Observation
import Stores

@MainActor
@Observable
public final class MyAccountViewState<Dependency: DependencyProtocol> {

    public typealias LoginContext = Stores.LoginContext<Dependency>

    public var accountStore: Dependency.AccountStore

    public var showsLogoutAlert: Bool = false

    public var isLoggingOut: Bool = false
    public var showsMultiAccountView: Bool = false

    public init(loginContext: LoginContext) {
        self.accountStore = loginContext.accountStore
    }

    public var me: Account {
        accountStore.me
    }

    public func onTapChangeAccountButton() {
        showsMultiAccountView = true
    }

    public func onTapLogoutButton() {
        showsLogoutAlert = true
    }

    public func onTapLogoutAlertLogoutButton() {
        guard !isLoggingOut else { return }
        isLoggingOut = true
        Task {
            defer { isLoggingOut = false }
            await Dependency.loginStore.logOut()
        }
    }

    public func task() async {
        do {
            try await accountStore.loadMe()
        } catch {
            print("Failed to fetch me error: \(error)")
        }
    }
}
