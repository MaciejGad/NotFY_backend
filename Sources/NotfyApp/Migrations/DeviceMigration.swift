import Fluent
import FluentMySQLDriver

struct DeviceMigration: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(Device.schema)
            .id()
            .field("token", .string, .required)
            .field("added_date", .datetime, .required)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema(Device.schema).delete()
    }
}
