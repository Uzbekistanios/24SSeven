
import Foundation

// MARK: - searchResult
struct SearchResultsModel: Codable {
    let pagination: searchPagination?
    let items: [searchItem]?
}

// MARK: - MainProduct
struct searchItem: Codable {
    var id: Int?
    var name: String?
    var image: MainImage?
    var price: Int?
    var priceDiscount: Int?
    var unit: MainUnit?
    var isFavorite: Bool?
    var isCard: Bool?
    var discountPercent: Int?
    var commentsCount: Int?
    var category: MainCategory?

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
}

// MARK: - searchCategory
struct searchCategory: Codable {
    let id: Int?
    let name: String?
}

// MARK: - searchImage
struct searchImage: Codable {
    let id: Int?
    let path, pathThumb: String?

    enum CodingKeys: String, CodingKey {
        case id, path
        case pathThumb = "path_thumb"
    }
}

// MARK: - searchUnit
struct searchUnit: Codable {
    let id: Int?
    let name: String?
    let count: Double?
}

// MARK: - searchPagination
struct searchPagination: Codable {
    let current: Int?
    let previous: Int?
    let next, total, perPage: Int?
    
    var nextPage: Int? {
        if let current = current, current < total ?? 1 {
            return current + 1
        }
        return nil
    }
}
