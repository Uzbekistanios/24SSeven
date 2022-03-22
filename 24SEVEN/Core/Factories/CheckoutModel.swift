
import Foundation

struct CheckoutModel: Codable {
    var status: Bool?

    enum CodingKeys: String, CodingKey {
        case status = "status"
    }
}
