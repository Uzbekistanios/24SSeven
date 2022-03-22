
struct LoginVerifyModel: Codable {
    var user: User?
    var accessToken: String?

    enum CodingKeys: String, CodingKey {
        case user = "user"
        case accessToken = "access_token"
    }
}

// MARK: - User
struct User: Codable {
    var id: Int?
    var firstName: String?
    var lastName: String?
    var avatar: String?
    var roleID: Int?
    var phone: Int?
    var gender: Bool?
    var birthDay: String?
    var notification: Bool?
    var language: String?
    var email: String?
    var postalAddress: String?
    var productsCount: Int?
    var addressesCount: Int?
    var ordersCount: Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "avatar"
        case roleID = "role_id"
        case phone = "phone"
        case gender = "gender"
        case birthDay = "birth_day"
        case notification = "notification"
        case language = "language"
        case email = "email"
        case postalAddress = "postal_address"
        case productsCount = "products_count"
        case addressesCount = "addresses_count"
        case ordersCount = "orders_count"
    }
}
