import Vapor

final class NotificationController: RouteCollection, Sendable {
    func boot(routes: any RoutesBuilder) throws {
        let notifications = routes.grouped("send")
        notifications.get(":channelID", use: sendNotification)
        notifications.post(":channelID", use: sendNotification)
    }
 
    func sendNotification(req: Request) async throws -> Notification {
        guard let channelID = req.parameters.get("channelID", as: UUID.self) else {
            throw Abort(.badRequest, reason: "Missing channel ID")
        }
        let notification: Notification
        guard let channel = try await Channel.find(channelID, on: req.db) else {
            throw Abort(.notFound, reason: "Channel not found")
        }
        if req.method == .POST {
            let data = try req.content.decode(CreateNotification.self)
            notification = try Notification(title: data.title, body: data.body, channelID: channelID)
        } else {
            notification = try Notification(title: channel.name, body: channel.description, channelID: channelID)
        }
        let devices = try await channel.$devices.query(on: req.db).all()
        print("Devices for channel \(channelID): \(devices.count)")
        try await notification.save(on: req.db)
        return notification
    }
    
    private struct CreateNotification: Content {
        let title: String
        let body: String?
    }
}
        
