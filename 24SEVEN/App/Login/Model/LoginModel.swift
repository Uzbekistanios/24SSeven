import Foundation

struct LoginResponse: Codable {
    var phone: Int?
    
    enum CodingKeys: String, CodingKey {
        case phone = "phone"
    }
}

struct LoginErrorResponse: Codable {
    var phone: [String]?
    
    enum CodingKeys: String, CodingKey {
        case phone = "phone"
    }
}
