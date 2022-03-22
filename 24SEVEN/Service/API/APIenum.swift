
enum API {

    case homePage
    case newsPage
    case newsItem(productId:Int)
    
    case categoryPage
    case categoryItems(sectionId:Int, page: Int, orderBy: String)
    case productItem(productId:Int)
    case addComment(productId: Int, firstName: String, body: String)
    
    case login(phone:String)
    case verify(phone:Int, code:Int)
    case logout
    
    case profile
    
    case favourites(page:Int)
    case addToFavourites(productId: Int)
    case removeFromFavourite(productId: Int)
    
    case addToCard(productId: Int)
    case getBasketItems(data: [String:Any])
    
    case getUserAddresses(page:Int)
    
    case getSpecificAddress(addressId: Int)
    case deleteSpecificAddress(addressId: Int)
    case updateSpecificAddress(addressId: Int, name:String, address:String, city:String, region:String, locationLat:String, locationLang:String, phone:String)
    
    case addAddress(name:String, address:String, city:String, region:String, locationLat:String, locationLang:String, phone:String)
    
    case checkout(paymentType:String, data: [String:String], addressName:String, addressMain: String, addressCity:String, addressRegion:String, phone:String, locationLat:String, locationLang:String)
    case checkOutWithAddress(paymentType:String, addressID: Int, data: [String:String])
    
    case updateProfile(firstName:String, secondName:String, birthDate:String, gender:Int)

    case orders(type: String, page:Int)
    case orderDetails(productId:Int)
    case deleteOrder(productId:Int)
    
    case search(query: String, page: Int, orderBy: String)
}
