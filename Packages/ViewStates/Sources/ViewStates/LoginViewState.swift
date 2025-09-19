import Entities
import Observation
import Stores

@MainActor
@Observable
public final class LoginViewState<Dependency: DependencyProtocol> {
    private var loginStore: Dependency.LoginStore {
        Dependency.loginStore
    }

    public var apiTokenText: String = ""
    public var showsLoginErrorAlert: Bool = false

    public init() {}

    internal var loginTask: Task<Void, Never>?

    public var isLoggingIn: Bool {
        loginTask != nil
    }

    public func onTapLogin() {
        guard loginTask == nil else { return }
        loginTask = Task {
            defer { loginTask = nil }
            do {
                try await loginStore.logIn(apiToken: .init(rawValue: apiTokenText))
            } catch {
                showsLoginErrorAlert = true
            }
        }
    }
}
