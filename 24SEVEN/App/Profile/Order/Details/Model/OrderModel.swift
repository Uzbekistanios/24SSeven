
import Foundation

struct OrdersDetail: Codable {
    let id, productsCount, priceProducts, priceDelivery: Int?
    let status, paymentType, paymentStatus, createdAt: String?
    let address: OrderDetailAddress?
    let products: [OrderDetailProduct]?

    enum CodingKeys: String, CodingKey {
        case id
        case productsCount = "products_count"
        case priceProducts = "price_products"
        case priceDelivery = "price_delivery"
        case status
        case paymentType = "payment_type"
        case paymentStatus = "payment_status"
        case createdAt = "created_at"
        case address, products
    }
}

// MARK: - OrderDetailAddress
struct OrderDetailAddress: Codable {
    let id: Int?
    let name, city, region: String?
    let phone: Int?
    let phoneOther: Int?
    let address: String?
    let location: OrderDetailLocation?

    enum CodingKeys: String, CodingKey {
        case id, name, city, region, phone
        case phoneOther = "phone_other"
        case address, location
    }
}

// MARK: - OrderDetailLocation
struct OrderDetailLocation: Codable {
    let lat, lng: String?
}

// MARK: - OrderDetailProduct
struct OrderDetailProduct: Codable {
    let id: Int?
    let name: String?
    let image: OrderDetailImage?
    let price: String?
    let count: Int?
    let unit: OrderDetailUnit?
}

// MARK: - OrderDetailImage
struct OrderDetailImage: Codable {
    let id: Int?
    let path, pathThumb: String?

    enum CodingKeys: String, CodingKey {
        case id, path
        case pathThumb = "path_thumb"
    }
}

// MARK: - OrderDetailUnit
struct OrderDetailUnit: Codable {
    let id: Int?
    let name: String?
    let count: Double?
}

