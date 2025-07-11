import APNS
import VaporAPNS
import APNSCore
import Vapor

func configureAPNS(_ app: Application) throws {
    let apnsPrivateKeyPath = try Environment.value("APNS_KEY_PATH")
    let keyID = try Environment.value("APNS_KEY_ID")
    let teamID = try Environment.value("APNS_TEAM_ID")
    
    let privateKey = try String(contentsOfFile: apnsPrivateKeyPath)
    
    // Configure APNs with the provided certificate and key
    let apnsConfig = APNSClientConfiguration(
        authenticationMethod: .jwt(
            privateKey: try .loadFrom(string: privateKey),
            keyIdentifier: keyID,
            teamIdentifier: teamID
        ),
        environment: .development
    )
    app.apns.containers.use(
        apnsConfig,
        eventLoopGroupProvider: .shared(app.eventLoopGroup),
        responseDecoder: JSONDecoder(),
        requestEncoder: JSONEncoder(),
        as: .default
    )
}
