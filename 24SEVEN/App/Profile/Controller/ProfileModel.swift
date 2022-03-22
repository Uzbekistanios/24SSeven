
struct ProfileUser: Codable {
    var id: Int?
    var avatar: String?
    var phone: Int?
    var firstName: String?
    var lastName: String?
    var birthDay: String?
    var gender: Bool?
    var email: String?
    var language: String?
    var favoritesCount: Int?
    var addressesCount: Int?
    var ordersCount: Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case avatar = "avatar"
        case phone = "phone"
        case firstName = "first_name"
        case lastName = "last_name"
        case birthDay = "birth_day"
        case gender = "gender"
        case email = "email"
        case language = "language"
        case favoritesCount = "favorites_count"
        case addressesCount = "addresses_count"
        case ordersCount = "orders_count"
    }
}
