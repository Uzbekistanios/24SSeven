
import Foundation

// MARK: - NewsModel
struct NewsModel: Codable {
    var pagination: NewsPagination?
    var items: [NewsItem]?

    enum CodingKeys: String, CodingKey {
        case pagination = "pagination"
        case items = "items"
    }
}

// MARK: - NewsItem
struct NewsItem: Codable {
    var id: Int?
    var name: String?
    var image: String?
    var views: Int?
    var createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image = "image"
        case views = "views"
        case createdAt = "created_at"
    }
}

// MARK: - NewsPagination
struct NewsPagination: Codable {
    var current: Int?
    var previous: Int?
    var next: Int?
    var total: Int?
    var perPage: Int?

    enum CodingKeys: String, CodingKey {
        case current = "current"
        case previous = "previous"
        case next = "next"
        case total = "total"
        case perPage = "perPage"
    }
}
