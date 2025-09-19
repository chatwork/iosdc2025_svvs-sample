import Entities
import Foundation
import Observation
import Repositories

public enum LoginError: Error {
    case notFoundAPIToken
    case invalidAPIToken
    case unexpected
}

@MainActor
@Observable
public final class LoginStore<Dependency: DependencyProtocol>: LoginStoreProtocol {
    public typealias ID = Login.ID
    public typealias Value = Login

    // 先頭が現在ログイン中のアカウント
    public private(set) var values: [Value] = []

    public var currentLogin: Login?

    nonisolated public init() {}

    public func logIn(apiToken: APIToken) async throws {
        let me = try await Dependency.LoginRepository.logIn(with: apiToken)
        values = await Dependency.LoginRepository.localLogins()
        currentLogin = Login(account: me, apiToken: apiToken, loggedInAt: Date())
    }

    public func logIn(with id: ID) async throws {
        let apiToken = await Dependency.LoginRepository.localLogins().first { $0.id == id }?.apiToken
        guard let apiToken else {
            throw LoginError.notFoundAPIToken
        }
        try await logIn(apiToken: apiToken)
    }

    // 再帰的にログインできるアカウントを探してログインする
    public func logInAutomatically() async {
        let localLogins = await Dependency.LoginRepository.localLogins()
        guard let currentAccountID = localLogins.first?.id else {
            values = await Dependency.LoginRepository.localLogins()
            return
        }
        do {
            try await logIn(with: currentAccountID)
        } catch {
            // ログインできないアカウントは削除し、他のアカウントでログインを試す
            await Dependency.LoginRepository.removeLocalLogin(with: currentAccountID)
            await logInAutomatically()
        }
    }

    public func logOut() async {
        guard let targetLogin = currentLogin else {
            return
        }
        currentLogin = nil
        await Dependency.LoginRepository.removeLocalLogin(with: targetLogin.id)
        await logInAutomatically()
    }
}
