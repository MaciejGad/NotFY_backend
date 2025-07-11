import Fluent
import Vapor

final class ChannelDevice: Model, Content, @unchecked Sendable {
    static let schema = "channel_device"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "channel_id")
    var channel: Channel
    
    @Parent(key: "device_id")
    var device: Device
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, channel: Channel, deviceId: Device, createdAt: Date = .now) throws {
        self.id = id
        self.$channel.id = try channel.requireID()
        self.$device.id = try deviceId.requireID()
        self.createdAt = createdAt
    }
}
