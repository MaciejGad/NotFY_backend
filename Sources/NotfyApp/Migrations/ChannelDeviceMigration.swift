import Fluent
import FluentMySQLDriver
import SQLKit

struct ChannelDeviceMigration: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("channel_device")
            .id()
            .field("channel_id", .uuid, .required, .references("channels", "id"))
            .field("device_id", .uuid, .required, .references("devices", "id"))
            .field("created_at", .datetime, .required, .sql(.default(SQLFunction.now)))
            .unique(on: "channel_id", "device_id")
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema("channel_device").delete()
    }
}
            
