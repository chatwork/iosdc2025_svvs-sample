import Entities
import Stores
import SwiftUI
import ViewStates

public struct MainTabView<Dependency: DependencyProtocol>: View {
    public typealias LoginContext = Stores.LoginContext<Dependency>
    public typealias ViewState = MainTabViewState<Dependency>

    @State var viewState: ViewState

    private var loginContext: LoginContext

    public init(loginContext: LoginContext) {
        self._viewState = State(wrappedValue: .init(loginContext: loginContext))
        self.loginContext = loginContext
    }

    public var body: some View {
        TabView(selection: $viewState.selectedTab) {
            Tab("チャット", systemImage: "bubble.left.and.bubble.right", value: TabKind.chat) {
                Dependency.roomListView(loginContext: loginContext)
            }
            Tab("アカウント", systemImage: "person.crop.circle", value: TabKind.account) {
                Dependency.myAccountView(loginContext: loginContext)
            }
        }
    }
}
