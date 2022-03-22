
import Foundation

// MARK: - orderOrders
struct OrdersModel: Codable {
    let pagination: OrderPagination?
    let items: [OrderItem]?
}

// MARK: - orderItem
struct OrderItem: Codable {
    let id, productsCount, priceProducts, priceDelivery: Int?
    let status, paymentType, paymentStatus, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case productsCount = "products_count"
        case priceProducts = "price_products"
        case priceDelivery = "price_delivery"
        case status
        case paymentType = "payment_type"
        case paymentStatus = "payment_status"
        case createdAt = "created_at"
    }
}

// MARK: - orderPagination
struct OrderPagination: Codable {
    let current: Int?
    let previous, next: Int?
    let total, perPage: Int?
    
    var nextPage: Int? {
        if let current = current, current < total ?? 1 {
            return current + 1
        }
        return nil
    }
}
