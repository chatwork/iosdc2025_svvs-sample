@MainActor
public protocol LoginScoped<Dependency> {
    associatedtype Dependency: DependencyProtocol
    func _configure(with loginContext: LoginContext<Dependency>)
}
