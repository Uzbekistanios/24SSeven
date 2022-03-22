
// MARK: - AddComment
struct AddComment: Codable {
    let id: Int?
    let firstName, body, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case body
        case createdAt = "created_at"
    }
}
