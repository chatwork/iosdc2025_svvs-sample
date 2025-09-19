import Entities
import Observation
import Stores

public enum TabKind: String, CaseIterable, Identifiable {
    case chat
    case account

    public var id: String { rawValue }
}

@MainActor
@Observable
public final class MainTabViewState<Dependency: DependencyProtocol> {

    public typealias LoginContext = Stores.LoginContext<Dependency>

    private var loginContext: LoginContext
    public var selectedTab: TabKind = .chat
    
    public init(loginContext: LoginContext) {
        self.loginContext = loginContext
    }
}
