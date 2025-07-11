import Vapor
import Fluent
import FluentMySQLDriver

func setupDatabase(_ app: Application) throws {
    let hostname = try Environment.value("DB_HOSTNAME")
    let username = try Environment.value("DB_USERNAME")
    let password = try Environment.value("DB_PASSWORD")
    let database = try Environment.value("DB_DATABASE")
    app.databases.use(.mysql(hostname: hostname, username: username, password: password, database: database), as: .mysql)
}

extension Environment {
    static func value(_ key: String) throws -> String {
        guard let value = Environment.get(key) else {
            throw Abort(.internalServerError, reason: "Environment variable '\(key)' is not set")
        }
        return value
    }
}
