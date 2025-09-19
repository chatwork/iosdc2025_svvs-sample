import Foundation

public struct APIClient: Sendable {
    private var apiToken: String
    private var baseURL: URL

    public init(apiToken: String, baseURL: URL) {
        self.apiToken = apiToken
        self.baseURL = baseURL
    }
}

// MARK: - fetch
public extension APIClient {
    func send<Request: APIRequestProtocol>(_ apiRequest: Request) async throws -> Request.Response {
        let request = try makeURLRequest(from: apiRequest)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let httpURLResponse = response as? HTTPURLResponse
            guard let statusCode = httpURLResponse?.statusCode else {
                throw APIError.unexpected
            }
            switch statusCode {
            case 200:
                let jsonDecoder = JSONDecoder()
                let result = try jsonDecoder.decode(Request.Response.self, from: data)
                return result
            case 204:
                throw APIError.emptyResponse
            case 401:
                throw APIError.invalidAPIToken
            default:
                throw APIError.unexpected
            }
        } catch {
            print("APIClient.send request:", apiRequest, "error:", error)
            throw error
        }
    }
}

// MARK: - private
private extension APIClient {
    func makeURLRequest(from apiRequest: some APIRequestProtocol) throws -> URLRequest {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path += apiRequest.path
        if let queryItems = apiRequest.queryItems {
            urlComponents?.queryItems = queryItems
        }
        guard let url = urlComponents?.url else {
            throw URLError(.badURL)
        }
        var request = URLRequest(
            url: url,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0
        )
        var headers: [String: String] = [
            "accept": "application/json",
            "x-chatworktoken": apiToken
        ]
        if let contentType = apiRequest.headerType.contentType {
            headers["Content-Type"] = contentType
        }

        request.httpMethod = apiRequest.method.rawValue
        request.httpBody = apiRequest.httpBody
        request.allHTTPHeaderFields = headers
        return request
    }
}
