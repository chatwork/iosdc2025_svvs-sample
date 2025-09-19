import Entities
import Observation
import Repositories
import Stores
import Testing
import UnimplementedStores
@testable import ViewStates

@MainActor
struct LoginViewStateTests {

    // MARK: - 初期状態のテスト
    
    @Test func `初期状態`() {
        let viewState = LoginViewState<UnimplementedDependency>()
        
        #expect(viewState.apiTokenText == "")
        #expect(viewState.showsLoginErrorAlert == false)
        #expect(viewState.isLoggingIn == false)
    }
    
    // MARK: - ログインボタンタップ時のテスト

    @MainActor
    struct OnTapLoginTests {

        // ログイン開始、完了を制御可能なモック
        final class MockLoginStore<Dependency: Stores.DependencyProtocol>: LoginStoreProtocol {
            // テスト側にログイン開始を通知するためのcontinuation
            var loginStarted: CheckedContinuation<Void, Never>?

            // テスト側からログイン完了（正常/異常）を制御するためのcontinuation
            var loginContinuation: CheckedContinuation<Void, Error>?

            // ログイン呼び出し回数をカウント
            private(set) var loginCallCount = 0

            func logIn(apiToken: APIToken) async throws {
                loginCallCount += 1
                try await withCheckedThrowingContinuation { continuation in
                    self.loginContinuation = continuation
                    loginStarted?.resume()
                }
            }
            nonisolated init() {}
        }

        @Test func `正常系`() async {
            enum Dependency: ViewStates.DependencyProtocol {
                typealias LoginStore = MockLoginStore<Self>
                static let loginStore: LoginStore = .init()
            }

            let viewState = LoginViewState<Dependency>()
            
            // ログイン実行前の状態確認
            #expect(!viewState.isLoggingIn, "ログイン中ではない")

            // ログインボタンタップ後、ログイン開始まで待機
            await withCheckedContinuation { continuation in
                Dependency.loginStore.loginStarted = continuation
                viewState.onTapLogin()
            }

            #expect(viewState.isLoggingIn, "ログイン中である")
            #expect(!viewState.showsLoginErrorAlert, "ログインエラーアラートを表示していない")

            // 正常完了させる
            Dependency.loginStore.loginContinuation?.resume()
            await viewState.loginTask?.value

            // ログイン完了
            #expect(!viewState.isLoggingIn, "ログイン中ではない")
            #expect(!viewState.showsLoginErrorAlert, "ログインエラーアラートを表示していない")
        }

        @Test func `異常系`() async {
            enum Dependency: ViewStates.DependencyProtocol {
                typealias LoginStore = MockLoginStore<Self>
                static let loginStore: LoginStore = .init()
            }

            enum TestError: Error {
                case loginFailed
            }

            let viewState = LoginViewState<Dependency>()
            
            // ログイン実行前の状態確認
            #expect(!viewState.isLoggingIn, "ログイン中ではない")

            // ログインボタンタップ後、ログイン開始まで待機
            await withCheckedContinuation { continuation in
                Dependency.loginStore.loginStarted = continuation
                viewState.onTapLogin()
            }
            
            #expect(viewState.isLoggingIn, "ログイン中である")
            #expect(viewState.showsLoginErrorAlert == false, "ログインエラーアラートを表示していない")

            // エラーで完了させる
            Dependency.loginStore.loginContinuation?.resume(throwing: TestError.loginFailed)
            await viewState.loginTask?.value

            // ログイン完了（エラー）
            #expect(!viewState.isLoggingIn, "ログイン中ではない")
            #expect(viewState.showsLoginErrorAlert == true, "ログインエラーアラートを表示している")
        }


        @Test func `重複実行の防止`() async {
            enum Dependency: ViewStates.DependencyProtocol {
                typealias LoginStore = MockLoginStore<Self>
                static let loginStore: LoginStore = .init()
            }

            let viewState = LoginViewState<Dependency>()

            // ログインボタンタップ後、ログイン開始まで待機
            await withCheckedContinuation { continuation in
                Dependency.loginStore.loginStarted = continuation
                viewState.onTapLogin()
            }
            #expect(viewState.isLoggingIn, "ログイン中である")
            #expect(Dependency.loginStore.loginCallCount == 1, "ログインが1回呼ばれた")

            // ログイン中の時点でタスクが存在することを確認
            #expect(viewState.loginTask != nil, "ログインタスクが存在する")

            // 既にログイン中なので、2回目のログイン実行は無視される
            viewState.onTapLogin()
            
            // まだログイン中であることを確認
            #expect(viewState.isLoggingIn, "まだログイン中")
            #expect(Dependency.loginStore.loginCallCount == 1, "ログインは1回のまま（重複実行されない）")

            // さらにもう一度呼び出してみる
            viewState.onTapLogin()
            #expect(Dependency.loginStore.loginCallCount == 1, "3回目も呼ばれない")

            // 最初のログインを正常完了
            Dependency.loginStore.loginContinuation?.resume()
            await viewState.loginTask?.value

            #expect(!viewState.isLoggingIn, "ログイン完了")
            #expect(Dependency.loginStore.loginCallCount == 1, "最終的にログインは1回のみ")
        }
    }
}
