
import Foundation

// MARK: - CategoryModelElement
struct CategoryModelElement: Codable {
    var id, productsCount: Int?
    var name, image: String?
    var parents: [CategoryModelElement]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try? container.decode(Int.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
        image = try? container.decode(String.self, forKey: .image)
        parents = try? container.decode([CategoryModelElement].self, forKey: .parents)
        productsCount = try? container.decode(Int.self, forKey: .productsCount)
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image = "image"
        case parents = "parents"
        case productsCount = "products_count"
    }
}

typealias CategoryModel = [CategoryModelElement]
