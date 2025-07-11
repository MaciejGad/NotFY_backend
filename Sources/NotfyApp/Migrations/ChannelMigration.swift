import Fluent
import FluentMySQLDriver
import SQLKit

struct ChannelMigration: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("channels")
            .id()
            .field("name", .string, .required)
            .field("description", .string, .required)
            .field("created_at", .datetime, .required, .sql(.default(SQLFunction.now)))
            .field("updated_at", .datetime, .required, .sql(.default(SQLFunction.now)))
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema("channels").delete()
    }
}
            
extension SQLFunction {
    static var now: SQLFunction {
        return SQLFunction("now")
    }
}
