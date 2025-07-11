import Vapor

/// Controller for registering a device with a unique identifier

final class DeviceRegistrationController: RouteCollection, Sendable {
    func boot(routes: any RoutesBuilder) throws {
        let devices = routes.grouped("device")
        devices.get(use: list)
        devices.post("register", use: registerDevice)
    }
    
    func registerDevice(req: Request) async throws -> Device {
        let data = try req.content.decode(CreateDevice.self)
        let device = Device(token: data.token)
        try await device.save(on: req.db)
        return device
    }
    
    func list(req: Request) async throws -> [Device] {
        try await Device.query(on: req.db).all()
    }
    
    private struct CreateDevice: Content {
        let token: String
    }
}
