
import Foundation

// MARK: - MainCatalogShowModel
struct MainCatalogShowModel: Codable {
    var sliders: [MainSlider]?
    var compilations: [MainCompilation]?
    var posts: [MainPost]?

    enum CodingKeys: String, CodingKey {
        case sliders = "sliders"
        case compilations = "compilations"
        case posts = "posts"
    }
}

// MARK: - MainSlider
struct MainSlider: Codable {
    var id: Int?
    var name: String?
    var image: String?
    var link: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image = "image"
        case link = "link"
    }
}

// MARK: - MainCompilation
struct MainCompilation: Codable {
    var id: Int?
    var title: String?
    var products: [MainProduct]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case products = "products"
    }
}

// MARK: - MainProduct
struct MainProduct: Codable {
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

// MARK: - MainCategory
struct MainCategory: Codable {
    var id: Int?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

// MARK: - MainImage
struct MainImage: Codable {
    var id: Int?
    var path: String?
    var pathThumb: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case path = "path"
        case pathThumb = "path_thumb"
    }
}

// MARK: - MainUnit
struct MainUnit: Codable {
    var id: Int?
    var name: String?
    var count: Double?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case count = "count"
    }
}

// MARK: - MainPost
struct MainPost: Codable {
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

