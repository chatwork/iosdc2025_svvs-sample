import UnimplementedStores
import ViewStates

extension ViewStates.DependencyProtocol {
    static var loginStore: Self.LoginStore { fatalError() }
}

enum UnimplementedDependency: ViewStates.DependencyProtocol {}
