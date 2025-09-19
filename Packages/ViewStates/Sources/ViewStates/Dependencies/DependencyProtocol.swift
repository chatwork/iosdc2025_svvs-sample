import Stores

public protocol DependencyProtocol: Stores.DependencyProtocol {
    static var loginStore: LoginStore { get }
}
