import Entities
import Stores
import SwiftUI
import ViewStates

public struct MyAccountView<Dependency: DependencyProtocol>: View {
    public typealias LoginContext = Stores.LoginContext<Dependency>
    public typealias ViewState = MyAccountViewState<Dependency>

    @State var viewState: ViewState
    private let loginContext: LoginContext

    public init(loginContext: LoginContext) {
        self._viewState = State(wrappedValue: .init(loginContext: loginContext))
        self.loginContext = loginContext
    }

    public var body: some View {
        accountInfoView()
            .navigationBarTitle("アカウント")
            .navigationBarTitleDisplayMode(.inline)
            .alert("ログアウトしますか？", isPresented: $viewState.showsLogoutAlert) {
                Button("キャンセル", role: .cancel) {}
                Button("ログアウト", role: .destructive) {
                    viewState.onTapLogoutAlertLogoutButton()
                }
            } message: {
                Text("\(viewState.me.name)からログアウトします。")
            }
            .sheet(isPresented: $viewState.showsMultiAccountView) {
                Dependency.multiLoginView()
            }
            .task {
                await viewState.task()
            }
    }
    
    @ViewBuilder
    private func accountInfoView() -> some View {
        Form {
            VStack {
                HStack {
                    AsyncImage(url: URL(string: viewState.me.avatarImageURL)) { phase in
                        switch phase {
                        case .success(let image):
                            image.resizable().aspectRatio(contentMode: .fill)
                        case .failure, .empty:
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(.secondary)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())

                    Text(viewState.me.name)
                        .font(.title)

                    Spacer()
                }
                Divider()
                    .padding(7)

                Button("アカウント切り替え") {
                    viewState.onTapChangeAccountButton()
                }
                .foregroundColor(.accentColor)
                .buttonStyle(.plain)
            }

            Section("Chatworkについて") {
                aboutRow(title: "Chatwork ID", content: viewState.me.chatworkID ?? "")
                aboutRow(title: "ログインメールアドレス", content: viewState.me.loginMail ?? "")
                aboutRow(title: "アカウント ID", content: viewState.me.id.rawValue.description)
            }
            .textCase(.none) // SectionTitleのローマ字箇所が全部大文字になるのを防ぐ

            Button {
                viewState.onTapLogoutButton()
            } label: {
                Text("ログアウト")
                    .foregroundColor(.primary)
            }
        }
    }

    @ViewBuilder
    private func aboutRow(title: String, content: String) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                Text(content)
                    .textSelection(.enabled) // 長押しでコピー
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}
