import Foundation

struct Message: Codable {
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case value = "message"
    }
}
