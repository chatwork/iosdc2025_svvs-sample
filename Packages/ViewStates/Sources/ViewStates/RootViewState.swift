import Entities
import Observation
import Stores

public enum Cover: Identifiable {
    case login
    case main(Login)

    public var id: String {
        switch self {
        case .login: "login"
        case .main: "main"
        }
    }
}

@MainActor
@Observable
public final class RootViewState<Dependency: DependencyProtocol> {

    public var cover: Cover?

    public init() {}

    public var loginStore: Dependency.LoginStore {
        Dependency.loginStore
    }

    public func setCover() {
        if let login = loginStore.currentLogin {
            cover = .main(login)
        } else {
            cover = .login
        }
    }

    public func onTransitionDidFinish() {
        setCover()
    }

    public func task() async {
        // 初回起動時に自動ログインを試みる
        await loginStore.logInAutomatically()
        setCover()

        // LoginStoreのcurrentLoginの変更時を検知してモーダルを閉じる
        let loginStore = self.loginStore
        let logins = Observations {
            loginStore.currentLogin
        }

        // 初回の値は無視
        for await _ in logins.dropFirst() {
            cover = nil
        }
    }
}
