import Entities
import Stores
import SwiftUI
import ViewStates

public struct MultiLoginView<Dependency: DependencyProtocol>: View {
    public typealias ViewState = MultiLoginViewState<Dependency>

    @State var viewState: ViewState = .init()

    public init() {}

    public var body: some View {
        NavigationStack {
            List {
                ForEach(viewState.logins) { login in
                    Button {
                        viewState.onTapAccountButton(accountID: login.id)
                    } label: {
                        HStack {
                            AsyncImage(url: URL(string: login.account.avatarImageURL)) { phase in
                                switch phase {
                                case .success(let image):
                                    image.resizable().aspectRatio(contentMode: .fill)
                                case .empty, .failure:
                                    Image(systemName: "person.circle")
                                        .resizable()
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(.circle)
                            Text(login.account.name)
                                .foregroundStyle(Color(uiColor: .label))
                            Spacer(minLength: 0)
                            if viewState.isMe(accountID: login.id) {
                                Image(systemName: "checkmark.circle.fill")
                            }
                        }
                    }
                }
                Button("既存アカウントでログイン") {
                    viewState.onTapExistedAccountLoginButton()
                }
            }
            .navigationTitle("アカウント切り替え")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $viewState.showsLoginView) {
                Dependency.loginView()
            }
        }
    }
}
