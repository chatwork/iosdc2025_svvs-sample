import ChatworkRepositories
import Entities
import Foundation
import Repositories
import Stores
import SwiftUI
import Views
import ViewStates

enum Dependency {}

extension Dependency: ChatworkRepositories.DependencyProtocol {
    static let baseURL = URL(string: "https://api.chatwork.com/v2")!
}

extension Dependency: Stores.DependencyProtocol {
    // MARK: Repositories
    typealias LoginRepository = ChatworkRepositories.LoginRepository<Self>
    typealias MeRepository = ChatworkRepositories.MeRepository<Self>
    typealias RoomRepository = ChatworkRepositories.RoomRepository<Self>
    typealias RoomMessagesRepository = ChatworkRepositories.RoomMessagesRepository<Self>

    // MARK: Stores
    typealias AccountStore = Stores.AccountStore<Dependency>
    typealias RoomStore = Stores.RoomStore<Dependency>
    typealias RoomMessagesStore = Stores.RoomMessagesStore<Dependency>
    typealias LoginStore = Stores.LoginStore<Self>
}

extension Dependency: ViewStates.DependencyProtocol {
    static let loginStore = LoginStore()
}

extension Dependency: Views.DependencyProtocol {
    typealias LoginContext = Stores.LoginContext<Self>

    // MARK: - From app life cycle

    @MainActor
    @ViewBuilder
    static func loginView() -> some View {
        Views.LoginView<Self>()
    }

    @MainActor
    @ViewBuilder
    static func rootView() -> some View {
        Views.RootView<Self>()
    }

    @MainActor
    @ViewBuilder
    static func mainTabView(login: Login) -> some View {
        let loginContext = LoginContext(login: login)
        Views.MainTabView<Self>(loginContext: loginContext)
    }

    @MainActor
    @ViewBuilder
    static func multiLoginView() -> some View {
        Views.MultiLoginView<Self>()
    }

    // MARK: - From login life cycle

    @MainActor
    @ViewBuilder
    static func myAccountView(loginContext: LoginContext) -> some View {
        Views.MyAccountView<Self>(loginContext: loginContext)
    }

    @MainActor
    @ViewBuilder
    static func roomDetailView(loginContext: LoginContext, roomID: Room.ID) -> some View {
        Views.RoomDetailView<Self>(loginContext: loginContext, roomID: roomID)
    }

    @MainActor
    @ViewBuilder
    static func roomListView(loginContext: LoginContext) -> some View {
        Views.RoomListView<Self>(loginContext: loginContext)
    }
}
