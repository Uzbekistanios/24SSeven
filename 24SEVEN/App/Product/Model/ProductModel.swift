
import Foundation

// MARK: - CategoryProductItem
struct CategoryProductItem: Codable {
    var id: Int?
    var name: String?
    var images: [CategoryImage]?
    var price: Int?
    var description: String?
    var priceDiscount: Int?
    var characteristics: [CategoryCharacteristic]?
    var unit: CategoryUnit?
    var isFavorite: Bool?
    var isCard: Bool?
    var discountPercent: Int?
    var commentsCount: Int?
    var category: Category?
    var comments: [CategoryComment]?
    var productsRelated: [CategoryProductsRelated]?
    
    
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

    struct CategoryCharacteristic: Codable {
        let id: Int?
        let name, value: String?
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case images = "images"
        case price = "price"
        case priceDiscount = "price_discount"
        case description = "description"
        case characteristics = "characteristics"
        case unit = "unit"
        case isFavorite = "is_favorite"
        case isCard = "is_card"
        case discountPercent = "discount_percent"
        case commentsCount = "comments_count"
        case category = "category"
        case comments = "comments"
        case productsRelated = "products_related"
    }
}

// MARK: - Category
struct Category: Codable {
    var id: Int?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

// MARK: - CategoryComment
struct CategoryComment: Codable {
    var id: Int?
    var firstName: String?
    var body: String?
    var createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case body = "body"
        case createdAt = "created_at"
    }
}

// MARK: - CategoryImage
struct CategoryImage: Codable {
    var id: Int?
    var path: String?
    var pathThumb: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case path = "path"
        case pathThumb = "path_thumb"
    }
}

// MARK: - CategoryProductsRelated
struct CategoryProductsRelated: Codable {
    var id: Int?
    var name: String?
    var image: CategoryImage?
    var price: Int?
    var priceDiscount: Int?
    var unit: CategoryUnit?
    var isFavorite: Bool?
    var isCard: Bool?
    var discountPercent: Int?
    var commentsCount: Int?
    var category: Category?
    
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

// MARK: - CategoryUnit
struct CategoryUnit: Codable {
    var id: Int?
    var name: String?
    var count: Double?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case count = "count"
    }
}
