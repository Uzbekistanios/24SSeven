
// MARK: - AddAdress
struct AddAdress: Codable {
    var id: Int?
    var name: String?
    var city: String?
    var region: String?
    var phone: Int?
    var phoneOther: String?
    var address: String?
    var location: AddLocation?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case city = "city"
        case region = "region"
        case phone = "phone"
        case phoneOther = "phone_other"
        case address = "address"
        case location = "location"
    }
}

// MARK: - AddLocation
struct AddLocation: Codable {
    var lat: String?
    var lng: String?

    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lng = "lng"
    }
}
