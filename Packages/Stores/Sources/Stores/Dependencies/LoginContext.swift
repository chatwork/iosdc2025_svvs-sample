import Entities
import Repositories

public final class LoginContext<Dependency: DependencyProtocol> {
    public typealias MeRepository = Dependency.MeRepository
    public typealias RoomRepository = Dependency.RoomRepository
    public typealias RoomMessagesRepository = Dependency.RoomMessagesRepository

    public let meRepository: MeRepository
    public let roomRepository: RoomRepository
    public let roomMessagesRepository: RoomMessagesRepository

    public typealias AccountStore = Dependency.AccountStore
    public typealias RoomStore = Dependency.RoomStore
    public typealias RoomMessagesStore = Dependency.RoomMessagesStore

    public let accountStore: AccountStore
    public let roomStore: RoomStore
    public let roomMessagesStore: RoomMessagesStore

    @MainActor
    public init(login: Login) {
        // Repositories
        self.meRepository = Dependency.MeRepository(login: login)
        self.roomRepository = Dependency.RoomRepository(login: login)
        self.roomMessagesRepository = Dependency.RoomMessagesRepository(login: login)

        // Stores
        self.accountStore = .init(me: login.account)
        self.roomStore = .init()
        self.roomMessagesStore = .init()

        accountStore._configure(with: self)
        roomStore._configure(with: self)
        roomMessagesStore._configure(with: self)
    }
}
