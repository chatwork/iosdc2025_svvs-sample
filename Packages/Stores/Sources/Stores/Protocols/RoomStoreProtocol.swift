import Entities
import Foundation
import Observation

@MainActor
public protocol RoomStoreProtocol<Dependency>: Observable, LoginScoped {
    var values: [Room] { get }
    func loadValue() async throws

    init()
}
