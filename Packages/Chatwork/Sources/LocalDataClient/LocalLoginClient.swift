import Entities
import Foundation
import KeychainAccess
import SwiftData

public enum LocalLoginClient {
    private static var keychainServiceKey: String { Bundle.main.bundleIdentifier ?? "kubell.SVVSSample" }

    /// ログインした時間が新しい順に取得する
    /// APITokenはKeychainから取得して復元
    public static func fetch() async throws -> [Login] {
        let entities = try await SwiftDatabase.shared.fetch(FetchDescriptor<LoginModel>(sortBy: [.init(\.loggedInAt, order: .reverse)]))
        let keychain = Keychain(service: Self.keychainServiceKey)
        let logins: [Login] = entities.compactMap {
            guard let token = try? keychain.get($0.account.id.rawValue.description) else {
                return nil
            }
            let apiToken = APIToken(rawValue: token)
            return Login(account: $0.account, apiToken: apiToken, loggedInAt: $0.loggedInAt)
        }
        return logins
    }

    public static func update(_ login: Login) async throws {
        try await SwiftDatabase.shared.update(login.entity, as: LoginModel.self)
        let keychain = Keychain(service: keychainServiceKey)
        try? keychain.set(login.apiToken.rawValue, key: login.account.id.rawValue.description)
    }

    public static func insert(_ login: Login) async throws {
        try await SwiftDatabase.shared.insert(login.entity, as: LoginModel.self)
        let keychain = Keychain(service: keychainServiceKey)
        try? keychain.set(login.apiToken.rawValue, key: login.account.id.rawValue.description)
    }

    public static func delete(_ id: Login.ID) async throws {
        try await SwiftDatabase.shared.delete(
            where: #Predicate { (model: LoginModel) -> Bool in
                model.id == id.rawValue
            }
        )
        let keychain = Keychain(service: keychainServiceKey)
        try? keychain.remove(id.rawValue.description)
    }
}

private extension Login {
    var entity: LoginModel.Entity {
        .init(account: account, loggedInAt: loggedInAt)
    }
}
