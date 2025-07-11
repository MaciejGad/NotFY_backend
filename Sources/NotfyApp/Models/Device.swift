import Fluent
import Vapor

final class Device: Model, Content, @unchecked Sendable {
    static let schema = "devices"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "token")
    var token: String
    
    @Field(key: "added_date")
    var addedDate: Date
    
    @Siblings(through: ChannelDevice.self, from: \.$device, to: \.$channel)
    var channels: [Channel]
    
    init() { }

    init(id: UUID? = nil, token: String, addedDate: Date = Date()) {
        self.id = id
        self.token = token
        self.addedDate = addedDate
    }
}
