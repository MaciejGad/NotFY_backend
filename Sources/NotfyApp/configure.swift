import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    // DB setup
    try setupDatabase(app)

    app.migrations.add(DeviceMigration())
    app.migrations.add(ChannelMigration())
    app.migrations.add(ChannelDeviceMigration())
    app.migrations.add(NotificationMigration())
    
    // APNS setup
    try configureAPNS(app)
    
    // register routes
    try routes(app)
}


