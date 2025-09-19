import Repositories

public protocol DependencyProtocol {

    // MARK: - Repositories
    associatedtype LoginRepository: LoginRepositoryProtocol
    associatedtype MeRepository: MeRepositoryProtocol
    associatedtype RoomRepository: RoomRepositoryProtocol
    associatedtype RoomMessagesRepository: RoomMessagesRepositoryProtocol

    // MARK: - Stores
    // App life cycle
    associatedtype LoginStore: LoginStoreProtocol

    // Login life cycle
    associatedtype AccountStore: AccountStoreProtocol<Self>
    associatedtype RoomStore: RoomStoreProtocol<Self>
    associatedtype RoomMessagesStore: RoomMessagesStoreProtocol<Self>
}
