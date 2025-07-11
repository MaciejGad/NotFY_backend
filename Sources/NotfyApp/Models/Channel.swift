import Fluent
import Vapor

final class Channel: Model, Content, @unchecked Sendable {
    static let schema = "channels"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "description")
    var description: String
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
        var updatedAt: Date?
    
    @Siblings(through: ChannelDevice.self, from: \.$channel, to: \.$device)
    var devices: [Device]
    
    @Children(for: \.$channel)
    var notifications: [Notification]
    
    init(id: UUID? = nil, name: String, description: String, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    init() {}
}
