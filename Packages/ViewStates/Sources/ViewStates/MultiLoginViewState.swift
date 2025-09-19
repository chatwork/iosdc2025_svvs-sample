import Entities
import Observation
import Stores

@MainActor
@Observable
public final class MultiLoginViewState<Dependency: DependencyProtocol> {
    private var loginStore: Dependency.LoginStore { Dependency.loginStore }

    public var logining: Bool = false
    public var showsLoginView: Bool = false

    public init() {}

    public var logins: [Login] {
        loginStore.values
    }

    public func isMe(accountID: Account.ID) -> Bool {
        loginStore.currentLogin?.id == accountID
    }

    public func onTapExistedAccountLoginButton() {
        showsLoginView = true
    }

    public func onTapAccountButton(accountID: Account.ID) {
        guard !logining, !isMe(accountID: accountID) else { return }

        logining = true
        Task {
            defer { logining = false }
            try await loginStore.logIn(with: accountID)
        }
    }
}
