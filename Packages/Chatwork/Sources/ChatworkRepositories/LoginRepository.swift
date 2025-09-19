import ChatworkAPIClient
import Entities
import Foundation
import LocalDataClient
import Repositories

public enum LoginRepository<Dependency: DependencyProtocol>: LoginRepositoryProtocol {

    public static func localLogins() async -> [Login] {
        let logins = try? await LocalLoginClient.fetch()
        return logins ?? []
    }

    public static func removeLocalLogin(with id: Login.ID) async {
        try? await LocalLoginClient.delete(id)
    }

    public static func logIn(with apiToken: APIToken) async throws -> Entities.Account {
        let request = MeRequest()
        let response = try await APIClient(apiToken: apiToken.rawValue, baseURL: Dependency.baseURL).send(request)
        let account = Entities.Account(from: response)
        // ログイン日時を設定
        let login = Login(account: account, apiToken: apiToken, loggedInAt: Date())
        // ログインしたアカウントをローカルに保存
        try await LocalLoginClient.insert(login)
        return account
    }
}
