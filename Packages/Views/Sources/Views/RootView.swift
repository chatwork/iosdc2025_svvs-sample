import Stores
import SwiftUI
import ViewStates

public struct RootView<Dependency: DependencyProtocol>: View {
    public typealias ViewState = RootViewState<Dependency>

    @State var viewState: ViewState = .init()

    public init() {}

    public var body: some View {
        Color.clear
            .overlay {
                ProgressView()
            }
            .fullScreenCover(item: .constant(viewState.cover)) {
                viewState.onTransitionDidFinish()
            } content: { cover in
                switch cover {
                case .login:
                    Dependency.loginView()

                case .main(let login):
                    Dependency.mainTabView(login: login)
                }
            }
            .task {
                await viewState.task()
            }
    }
}
