
import Foundation

// MARK: - ViewAllCategoryItem
struct ViewAllCategoryItem: Codable {
    var pagination: ViewAllPagination?
    var items: [ViewAllItem]?

    enum CodingKeys: String, CodingKey {
        case pagination = "pagination"
        case items = "items"
    }
}

// MARK: - ViewAllItem
struct ViewAllItem: Codable {
    var id: Int?
    var name: String?
    var image: ViewAllImage?
    var price: Int?
    var priceDiscount: Int?
    var unit: ViewAllUnit?
    var isFavorite: Bool?
    var isCard: Bool?
    var discountPercent: Int?
    var commentsCount: Int?
    var category: ViewAllCategory?
    
    var actualPrice: Int? {
        if priceDiscount != nil {
            return priceDiscount
        }
        return price
    }
    
    var discountedPrice: Int? {
        if priceDiscount != nil {
            return price
        }
        return priceDiscount
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image = "image"
        case price = "price"
        case priceDiscount = "price_discount"
        case unit = "unit"
        case isFavorite = "is_favorite"
        case isCard = "is_card"
        case discountPercent = "discount_percent"
        case commentsCount = "comments_count"
        case category = "category"
    }
}

// MARK: - ViewAllCategory
struct ViewAllCategory: Codable {
    var id: Int?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

// MARK: - ViewAllImage
struct ViewAllImage: Codable {
    var id: Int?
    var path: String?
    var pathThumb: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case path = "path"
        case pathThumb = "path_thumb"
    }
}

// MARK: - ViewAllUnit
struct ViewAllUnit: Codable {
    var id: Int?
    var name: String?
    var count: Double?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case count = "count"
    }
}

// MARK: - ViewAllPagination
struct ViewAllPagination: Codable {
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
    
    var nextPage: Int? {
        if let current = current, current < total ?? 1 {
            return current + 1
        }
        return nil
    }
}
