import Fluent
import FluentMySQLDriver
import SQLKit

struct NotificationMigration: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(Notification.schema)
            .id()
            .field("title", .string, .required)
            .field("body", .string)
            .field("channel_id", .uuid, .required, .references(Channel.schema, "id"))
            .field("timestamp", .datetime, .required, .sql(.default(SQLFunction.now)))
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema(Notification.schema).delete()
    }
}
