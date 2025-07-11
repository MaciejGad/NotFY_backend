import Fluent
import Vapor

final class Notification: Model, Content, @unchecked Sendable {
    static let schema = "notifications"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "body")
    var body: String?
    
    @Parent(key: "channel_id")
    var channel: Channel
    
    @Timestamp(key: "timestamp", on: .create)
    var createdAt: Date?
    
    init() {}
    
    init(id: UUID? = nil, title: String, body: String?, channelID: Channel.IDValue, createdAt: Date? = nil) throws {
        self.id = id
        self.title = title
        self.body = body
        self.createdAt = createdAt
        self.$channel.id = channelID
    }
}





