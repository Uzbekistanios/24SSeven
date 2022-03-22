// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let addressAddressModel = try? newJSONDecoder().decode(addressAddressModel.self, from: jsonData)

import Foundation

// MARK: - addressAddressModel
struct AddressModel: Codable {
    var pagination: AddressPagination?
    var items: [AddressItem]?

    enum CodingKeys: String, CodingKey {
        case pagination = "pagination"
        case items = "items"
    }
}

// MARK: - addressItem
struct AddressItem: Codable {
    var id: Int?
    var name: String?
    var city: String?
    var region: String?
    var address: String?
    var apartment: String?
    var floor: String?
    var entrance: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case city = "city"
        case region = "region"
        case address = "address"
        case apartment = "apartment"
        case floor = "floor"
        case entrance = "entrance"
    }
}

// MARK: - addressPagination
struct AddressPagination: Codable {
    var current: Int?
    var previous: Int?
    var next: Int?
    var total: Int?
    var perPage: Int?
    
    
    var nextPage: Int? {
        if let current = current, current < total ?? 1 {
            return current + 1
        }
        return nil
    }

    enum CodingKeys: String, CodingKey {
        case current = "current"
        case previous = "previous"
        case next = "next"
        case total = "total"
        case perPage = "perPage"
    }
}
