import struct Foundation.Date

public struct Login: Sendable, Codable, Hashable, Identifiable {
    public var id: Account.ID { account.id }
    public var account: Account
    public var apiToken: APIToken
    public var loggedInAt: Date
    public init(
        account: Account,
        apiToken: APIToken,
        loggedInAt: Date
    ) {
        self.account = account
        self.apiToken = apiToken
        self.loggedInAt = loggedInAt
    }
}
