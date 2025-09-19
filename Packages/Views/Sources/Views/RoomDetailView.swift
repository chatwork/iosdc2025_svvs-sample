import Entities
import Stores
import SwiftUI
import ViewStates

public struct RoomDetailView<Dependency: DependencyProtocol>: View {
    public typealias LoginContext = Stores.LoginContext<Dependency>
    public typealias ViewState = RoomDetailViewState<Dependency>

    @State var viewState: ViewState
    @FocusState private var focused: Bool

    // MessageEditor用の定数
    private let uiFont: UIFont = .preferredFont(forTextStyle: .body)
    private let maxHeight: CGFloat = 300

    public init(loginContext: LoginContext, roomID: Room.ID) {
        self._viewState = State(wrappedValue: .init(loginContext: loginContext, roomID: roomID))
    }

    public var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                List {
                    ForEach(viewState.messages) { message in
                        VStack {
                            if message.id == viewState.oldestUnreadMessageID {
                                HStack {
                                    Rectangle()
                                        .fill(.pink)
                                        .frame(height: 1)

                                    Text("未読メッセージ")
                                        .foregroundColor(.pink)
                                        .font(.caption)
                                        .padding(5)
                                    Rectangle()
                                        .fill(.pink)
                                        .frame(height: 1)
                                }
                                .padding(.bottom, 15)
                            }
                            TimelineMessageCell(
                                message: message,
                                account: viewState.account(for: message.accountID)
                            )
                        }
                        .listRowSeparator(.hidden)
                        .id(message.id)
                    }
                }
                .listStyle(.plain)
                .scrollDismissesKeyboard(.interactively)
                .onChange(of: viewState.scrollTargetMessageID) { _, targetID in
                    if let targetID {
                        withAnimation {
                            proxy.scrollTo(targetID, anchor: .top)
                        }
                    }
                }

            }

            HStack(alignment: .bottom) {
                MessageEditor(
                    uiFont: uiFont,
                    text: $viewState.editingMessage,
                    placeholder: "ここにメッセージ内容を入力",
                    maxHeight: focused ? maxHeight: MessageEditor.minHeight(uiFont: uiFont)
                )
                .focused($focused)
                .disabled(viewState.room?.hasSendPermission != true) // disabled when hasSendPermission is flase or nil

                Button {
                    focused = false
                    viewState.onTapSend()
                } label: {
                    Text("送信")
                        .bold()
                        .foregroundColor(viewState.canSend ? .accentColor : .secondary)
                        .frame(height: MessageEditor.minHeight(uiFont: uiFont))
                }
                .disabled(!viewState.canSend)
            }
            .padding(10)
            .background(.ultraThinMaterial)
        }
        .navigationTitle(viewState.room?.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .loading(viewState.isLoading)
        .alert(.init("取得失敗"), isPresented: $viewState.showsFailedToLoadMessagesAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("メッセージを取得できませんでした。")
        }
        .alert(.init("送信失敗"), isPresented: $viewState.showsMessageSendFailureAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("メッセージを送信できませんでした。")
        }
        .task {
            await viewState.refresh()
        }
    }
}
