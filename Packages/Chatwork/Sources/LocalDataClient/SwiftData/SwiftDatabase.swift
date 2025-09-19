import Foundation
import SwiftData

@ModelActor
actor SwiftDatabase {
    static let modelTypes: [any PersistentModel.Type] = [
        LoginModel.self
    ]

    static let shared: SwiftDatabase = {
        do {
            let schema = Schema(modelTypes)
            let modelConfiguration = ModelConfiguration(
                schema: schema,
                url: URL.documentsDirectory.appendingPathComponent("LocalDataClient.sqlite")
            )
            let modelContainer = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
            return SwiftDatabase(modelContainer: modelContainer)
        } catch {
            fatalError("Failed to initialize SwiftDatabase: \(error)")
        }
    }()

    func delete<T: PersistentModel>(
        where predicate: Predicate<T>?
    ) throws {
        try modelContext.delete(model: T.self, where: predicate)
    }

    func insert<Model: PersistentModel>(_ entity: Model.Entity, as model: Model.Type) throws where Model: EntityConvertible {
        let model = Model(from: entity)
        modelContext.insert(model)
        try modelContext.save()
    }

    func fetch<T: EntityConvertible>(
        _ descriptor: FetchDescriptor<T>
    ) throws -> [T.Entity] {
        let models = try modelContext.fetch(descriptor)
        return models.map { $0.entity() }
    }

    func update<Model: PersistentModel>(
        _ entity: Model.Entity,
        as model: Model.Type
    ) async throws where Model: EntityConvertible {
        let descriptor = FetchDescriptor<Model>(predicate: #Predicate { $0.id == entity.id.rawValue  } )
        let models = try modelContext.fetch(descriptor)
        guard let model = models.first else {
            let model: Model = .init(from: entity)
            modelContext.insert(model)
            return
        }
        model.update(from: entity)
        try modelContext.save()
    }
}
