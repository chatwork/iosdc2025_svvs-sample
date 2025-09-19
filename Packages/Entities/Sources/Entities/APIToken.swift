public struct APIToken: Codable, RawRepresentable, Sendable, Hashable, ExpressibleByStringLiteral {
    public var rawValue: String
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    public init(stringLiteral value: String) {
        self.rawValue = value
    }
}
