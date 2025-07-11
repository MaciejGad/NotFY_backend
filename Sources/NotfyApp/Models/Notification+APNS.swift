import APNS
import VaporAPNS
import APNSCore

extension Notification {
    struct Payload: Codable {
        let acme1: String
        let acme2: Int
    }
    
    func createAPNSNotification(topic: String) -> APNSAlertNotification<Notification.Payload> {
        // Custom Codable Payload
        let payload = Payload(acme1: "hey", acme2: 2)
        let alert = APNSAlertNotification(
            alert: .init(
                title: .raw(title),
                subtitle: nil,
                body: body.map { .raw($0) } ?? nil
            ),
            expiration: .immediately,
            priority: .immediately,
            topic: topic,
            payload: payload,
            apnsID: id
        )

        return alert
    }
}
