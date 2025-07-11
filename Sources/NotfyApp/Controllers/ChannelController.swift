import Vapor

/// Controller for managing channels

public final class ChannelController: RouteCollection, Sendable {
    public func boot(routes: any RoutesBuilder) throws {
        let channels = routes.grouped("channels")
        channels.get(use: list)
        channels.post("create", use: createChannel)
        channels.delete(":channelID", use: deleteChannel)
        channels.get(":channelID", use: getChannel)
        channels.get(":channelID", "add", ":deviceID", use: addDeviceToChannel)
    }
    
    func createChannel(req: Request) async throws -> Channel {
        let data = try req.content.decode(CreateChannel.self)
        let channel = Channel(name: data.name, description: data.description)
        try await channel.save(on: req.db)
        return channel
    }
    
    func list(req: Request) async throws -> [Channel] {
        try await Channel.query(on: req.db).all()
    }
    
    func deleteChannel(req: Request) async throws -> HTTPStatus {
        guard let channelID = req.parameters.get("channelID", as: UUID.self) else {
            throw Abort(.badRequest, reason: "Missing channel ID")
        }
        guard let channel = try await Channel.find(channelID, on: req.db) else {
            throw Abort(.notFound, reason: "Channel not found")
        }
        try await channel.delete(on: req.db)
        return .noContent
    }
    
    func getChannel(req: Request) async throws -> Channel {
         guard let channelID = try? req.parameters.require("channelID", as: UUID.self) else {
            throw Abort(.badRequest, reason: "Missing channel ID")
        }
        return try await Channel.find(channelID, on: req.db)!
    }

    func addDeviceToChannel(req: Request) async throws -> Channel {
        guard let channelID = req.parameters.get("channelID", as: UUID.self),
              let deviceID = req.parameters.get("deviceID", as: UUID.self) else {
            throw Abort(.badRequest, reason: "Missing channel or device ID")
        }
        guard let channel = try await Channel.find(channelID, on: req.db) else {
            throw Abort(.notFound, reason: "Channel not found")
        }
        guard let device = try await Device.find(deviceID, on: req.db) else {
            throw Abort(.notFound, reason: "Device not found")
        }
        try await channel.$devices.attach(device, method: .ifNotExists, on: req.db)
        try await channel.$devices.load(on: req.db)
        return channel
    }
            
    
    private struct CreateChannel: Content {
        let name: String
        let description: String
    }
}

