import Foundation

public enum APIError: Error {
    case emptyResponse // レスポンスが空
    case invalidAPIToken // 401エラー
    case unexpected
}
