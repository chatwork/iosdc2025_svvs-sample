import Entities
import Stores
import SwiftUI
import ViewStates

public struct LoginView<Dependency: DependencyProtocol>: View {
    public typealias ViewState = LoginViewState<Dependency>

    @Environment(\.openURL) private var openURL
    @State private var viewState: ViewState = .init()

    public init() {}

    public var body: some View {
        VStack(spacing: 35) {
            Text("ログイン")
                .font(.largeTitle)
                .fontWeight(.medium)

            VStack(spacing: 15) {
                TextField("APIToken", text: $viewState.apiTokenText, prompt: Text("APIトークンを入力"))
                    .keyboardType(.asciiCapable)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                HStack {
                    Spacer()
                    Button {
                        openURL(URL(string: "https://help.chatwork.com/hc/ja/articles/115000172402-API%E3%83%88%E3%83%BC%E3%82%AF%E3%83%B3%E3%82%92%E7%99%BA%E8%A1%8C%E3%81%99%E3%82%8B")!)
                    } label: {
                        Text("APIトークンとは？")
                            .font(.caption)
                    }
                }
            }
            Button("ログイン") {
                viewState.onTapLogin()
            }
            .disabled(viewState.apiTokenText.isEmpty || viewState.isLoggingIn)

            Spacer()

        }
        .padding(24)
        .alert("ログインに失敗しました", isPresented: $viewState.showsLoginErrorAlert) {
            Button("OK", role: .cancel) {}
        }
        .loading(viewState.isLoggingIn)
    }
}
