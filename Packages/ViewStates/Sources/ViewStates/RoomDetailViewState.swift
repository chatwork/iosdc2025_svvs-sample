import Entities
import Observation
import Stores

@MainActor
@Observable
public final class RoomDetailViewState<Dependency: DependencyProtocol> {

    public typealias LoginContext = Stores.LoginContext<Dependency>

    public let accountStore: Dependency.AccountStore
    public let roomStore: Dependency.RoomStore
    public let roomMessagesStore: Dependency.RoomMessagesStore

    public let roomID: Room.ID
    public var isLoading: Bool = false
    public var editingMessage: String = ""

    // alert
    public var showsFailedToLoadMessagesAlert: Bool = false
    public var showsMessageSendFailureAlert: Bool = false

    // 未読線
    public var oldestUnreadMessageID: Message.ID?
    public var scrollTargetMessageID: Message.ID?

    public var room: Room? {
        roomStore.values.first { $0.id == roomID }
    }
    
    public var messages: [Message] {
        roomMessagesStore.values[roomID] ?? []
    }
    
    public var canSend: Bool {
        !editingMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !isLoading
    }

    public init(loginContext: LoginContext, roomID: Room.ID) {
        self.roomID = roomID
        self.accountStore = loginContext.accountStore
        self.roomStore = loginContext.roomStore
        self.roomMessagesStore = loginContext.roomMessagesStore
    }

    public func account(for id: Account.ID) -> Account? {
        return accountStore.values[id]
    }

    public func refresh() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            try await roomMessagesStore.loadValue(for: roomID)
            guard let oldestUnreadMessageIndex else {
                oldestUnreadMessageID = nil
                scrollTargetMessageID = messages.last?.id
                return
            }
            oldestUnreadMessageID = messages[oldestUnreadMessageIndex].id
            scrollTargetMessageID = oldestUnreadMessageID
        } catch {
            showsFailedToLoadMessagesAlert = true
            print("Failed to load messages for room \(roomID): \(error)")
        }
    }

    public var oldestUnreadMessageIndex: Int? {
        guard !messages.isEmpty, let unreadNum = room?.unreadNum, unreadNum > 0 else {
            return nil
        }
        return min(messages.count - 1, max(0, messages.count - unreadNum))
    }

    public func onTapSend() {
        guard !isLoading else { return }
        isLoading = true
        Task {
            defer { isLoading = false }
            do {
                let _ = try await roomMessagesStore.send(editingMessage, on: roomID)
                editingMessage = ""
                scrollTargetMessageID = messages.last?.id
            } catch {
                showsMessageSendFailureAlert = true
                throw error
            }
        }
    }
}
