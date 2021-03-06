import Foundation

public struct SSHKey: Resource {
    public let key: String
    public let name: String
    public let userID: UUID

    public let id: UUID
    public let createdAt: String
    public let updatedAt: String
}

public struct SSHKeyApi {
    public let token: Token
    private let access: ResourceAccess<SSHKey>

    public init(with token: Token) {
        self.token = token
        self.access = SSHKey.Access(with: token, baseUrl: gitSSHKeysUrl)
    }

    public func add(name: String, key: String) throws -> SSHKey {
        struct Package: Resource {
            let name: String
            let key: String
        }
        let package = Package(name: name, key: key)
        return try access.create(package)
    }

    public func list() throws -> [SSHKey] {
        return try access.list()
    }

    public func delete(_ key: SSHKey) throws {
        return try access.delete(id: key.id.uuidString)
    }
}
