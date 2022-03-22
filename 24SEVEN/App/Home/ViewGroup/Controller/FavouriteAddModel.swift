
import Foundation

// MARK: - addAddUserFavourites
struct AddUserFavourites: Codable {
    let id: Int?
    let name: String?
    let images: [addImage]?
    let price: Int?
    let addUserFavouritesDescription: String?
    let priceDiscount: Int?
    let characteristics: [addCharacteristic]?
    let unit: addUnit?
    let isFavorite, isCard: Bool?
    let discountPercent, commentsCount: Int?
    let category: addCategory?
    let comments: [addComment]?
    let productsRelated: [addProductsRelated]?

    enum CodingKeys: String, CodingKey {
        case id, name, images, price
        case addUserFavouritesDescription = "description"
        case priceDiscount = "price_discount"
        case characteristics, unit
        case isFavorite = "is_favorite"
        case isCard = "is_card"
        case discountPercent = "discount_percent"
        case commentsCount = "comments_count"
        case category, comments
        case productsRelated = "products_related"
    }
}

// MARK: - addCategory
struct addCategory: Codable {
    let id: Int?
    let name: String?
}

// MARK: - addCharacteristic
struct addCharacteristic: Codable {
    let id: Int?
    let name, value: String?
}

// MARK: - addComment
struct addComment: Codable {
    let id: Int?
    let firstName, body, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case body
        case createdAt = "created_at"
    }
}

// MARK: - addImage
struct addImage: Codable {
    let id: Int?
    let path, pathThumb: String?

    enum CodingKeys: String, CodingKey {
        case id, path
        case pathThumb = "path_thumb"
    }
}

// MARK: - addProductsRelated
struct addProductsRelated: Codable {
    let id: Int?
    let name: String?
    let image: addImage?
    let price: Int?
    let priceDiscount: Int?
    let unit: addUnit?
    let isFavorite, isCard: Bool?
    let discountPercent, commentsCount: Int?
    let category: addCategory?

    enum CodingKeys: String, CodingKey {
        case id, name, image, price
        case priceDiscount = "price_discount"
        case unit
        case isFavorite = "is_favorite"
        case isCard = "is_card"
        case discountPercent = "discount_percent"
        case commentsCount = "comments_count"
        case category
    }
}

// MARK: - addUnit
struct addUnit: Codable {
    let id: Int?
    let name: String?
    let count: Double?
}
