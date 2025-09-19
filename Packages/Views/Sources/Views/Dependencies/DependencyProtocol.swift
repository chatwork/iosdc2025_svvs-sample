import Entities
import Stores
import SwiftUI
import ViewStates

public protocol DependencyProtocol: ViewStates.DependencyProtocol {

    // From app life cycle

    associatedtype LoginView: View
    @MainActor
    static func loginView() -> LoginView

    associatedtype RootView: View
    @MainActor
    static func rootView() -> RootView

    associatedtype MainTabView: View
    @MainActor
    static func mainTabView(login: Login) -> MainTabView

    associatedtype MultiLoginView: View
    @MainActor
    static func multiLoginView() -> MultiLoginView

    // From login life cycle

    associatedtype MyAccountView: View
    @MainActor
    static func myAccountView(loginContext: LoginContext<Self>) -> MyAccountView

    associatedtype RoomDetailView: View
    @MainActor
    static func roomDetailView(loginContext: LoginContext<Self>, roomID: Room.ID) -> RoomDetailView

    associatedtype RoomListView: View
    @MainActor
    static func roomListView(loginContext: LoginContext<Self>) -> RoomListView
}
