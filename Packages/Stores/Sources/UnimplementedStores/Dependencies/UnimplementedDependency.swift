import Stores
import UnimplementedRepositories

public extension DependencyProtocol {

    // MARK: - Repositories
    typealias LoginRepository = UnimplementedLoginRepository
    typealias MeRepository = UnimplementedMeRepository
    typealias RoomRepository = UnimplementedRoomRepository
    typealias RoomMessagesRepository = UnimplementedRoomMessagesRepository


    // MARK: - Stores
    // App life cycle
    typealias LoginStore = UnimplementedLoginStore

    // Login life cycle
    typealias AccountStore = UnimplementedAccountStore<Self>
    typealias RoomStore = UnimplementedRoomStore<Self>
    typealias RoomMessagesStore = UnimplementedRoomMessagesStore<Self>
}

public enum UnimplementedDependency: DependencyProtocol {}
