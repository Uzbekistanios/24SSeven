
import Foundation

// MARK: - CardCheckoutItemCard
struct CardCheckoutItemCard: Codable {
    var total: Int?
    var products: [CardCheckoutItemProduct]?
    var deliveryPrice: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case products = "products"
        case deliveryPrice = "delivery_price"
    }
}

// MARK: - CardCheckoutItemProduct
struct CardCheckoutItemProduct: Codable {
    var id: Int?
    var name: String?
    var image: CardCheckoutItemImage?
    var price: Int?
    var priceDiscount: Int?
    var unit: CardCheckoutItemUnit?
    var isFavorite: Bool?
    var isCard: Bool?
    var discountPercent: Int?
    var commentsCount: Int?
    var category: CardCheckoutItemCategory?

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

// MARK: - CardCheckoutItemCategory
struct CardCheckoutItemCategory: Codable {
    var id: Int?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

// MARK: - CardCheckoutItemImage
struct CardCheckoutItemImage: Codable {
    var id: Int?
    var path: String?
    var pathThumb: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case path = "path"
        case pathThumb = "path_thumb"
    }
}

// MARK: - CardCheckoutItemUnit
struct CardCheckoutItemUnit: Codable {
    var id: Int?
    var name: String?
    var count: Double?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case count = "count"
    }
}
