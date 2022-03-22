

// MARK: - NewsItemNewsModel
struct NewsItemNewsModel: Codable {
    var id: Int?
    var name: String?
    var language: String?
    var content: String?
    var views: Int?
    var image: String?
    var createdAt: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case language = "language"
        case content = "content"
        case views = "views"
        case image = "image"
        case createdAt = "created_at"
        case url = "url"
    }
}
