
import Foundation

// MARK: - editEditAddress
struct EditAddress: Codable {
    let id: Int?
    let name, city, region: String?
    let phone: Int?
    let phoneOther: Int?
    let address: String?
    let location: editLocation?

    enum CodingKeys: String, CodingKey {
        case id, name, city, region, phone
        case phoneOther = "phone_other"
        case address, location
    }
}

// MARK: - editLocation
struct editLocation: Codable {
    let lat, lng: String?
}
