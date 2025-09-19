import Entities
import Stores
import SwiftUI
import ViewStates

public struct RoomListView<Dependency: DependencyProtocol>: View {
    public typealias LoginContext = Stores.LoginContext<Dependency>
    public typealias ViewState = RoomListViewState<Dependency>

    @State var viewState: ViewState
    private let loginContext: LoginContext
    
    public init(loginContext: LoginContext) {
        self._viewState = State(wrappedValue: .init(loginContext: loginContext))
        self.loginContext = loginContext
    }
    
    public var body: some View {
        NavigationStack {
            List(viewState.rooms, selection: $viewState.selectedRoom) { room in
                NavigationLink(value: room) {
                    RoomListCell(room: room)
                }
            }
            .listStyle(.plain)
            .navigationDestination(item: $viewState.selectedRoom) { room in
                Dependency.roomDetailView(loginContext: loginContext, roomID: room.id)
            }
            .refreshable {
                await viewState.refresh()
            }
            .task {
                await viewState.task()
            }
        }
    }
}
