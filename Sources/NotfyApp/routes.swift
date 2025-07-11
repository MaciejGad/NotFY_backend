import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "NotFY works!"
    }
    try app.register(collection: DeviceRegistrationController())
    try app.register(collection: ChannelController())
    try app.register(collection: NotificationController())
}
