
import UIKit
import Moya

extension API : TargetType {
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        
        case .login(phone: let phone):
            return .requestData(jsonToData(jsonDic: ["phone":phone])!)
            
        case .verify(phone: let phone, code: let code):
            return .requestData(jsonToData(jsonDic: ["phone":phone ,"verify_code":code])!)
            
        case .addComment(productId: _, firstName: let firstName, body: let body):
            return .requestData(jsonToData(jsonDic: ["first_name": firstName, "body": body])!)
            
        case .favourites(page: let page):
            return .requestParameters(parameters: ["page":page], encoding: URLEncoding.default)
            
        case .categoryItems(sectionId: _, page: let page, orderBy: let orderBy):
            return .requestParameters(parameters: ["page":page, "orderBy": orderBy], encoding: URLEncoding.default)
            
        case .orders(type: let type, page: let page):
            return .requestParameters(parameters: ["type":type, "page":page], encoding: URLEncoding.default)
            
        case .getUserAddresses(page: let page):
            return .requestParameters(parameters: ["page":page], encoding: URLEncoding.default)
            
        case .getBasketItems(let data):
            return .requestParameters(parameters: data, encoding: URLEncoding.default)
            
        case .updateProfile(firstName: let name, secondName: let surName, birthDate: let bod, gender: let gender):
            return .requestParameters(parameters: ["first_name":name, "last_name":surName, "birth_day":bod, "gender":gender], encoding: URLEncoding.default)
            
        case .addAddress(name: let name, address: let address, city: let city, region: let region, locationLat: let locationLat, locationLang: let locationLang, phone: let phone):
            return .requestParameters(parameters: ["name":name,"address":address,"city":city,"region":region,"location[lat]":locationLat,"location[lng]":locationLang,"phone":phone], encoding: URLEncoding.default)
            
        case .updateSpecificAddress(addressId: _, name: let name, address: let address, city: let city, region: let region, locationLat: let locationLat, locationLang: let locationLang, phone: let phone):
            return .requestParameters(parameters: ["name":name,"address":address,"city":city,"region":region,"location[lat]":locationLat,"location[lng]":locationLang,"phone":phone], encoding: URLEncoding.default)
            
        case  .checkout(paymentType: let paymentType, data: let data, addressName: let addressName, addressMain: let addressMain, addressCity: let addressCity, addressRegion: let addressRegion, phone: let phone, locationLat: let locationLat, locationLang: let locationLang):
            
            var params = ["payment_type" : paymentType, "address[name]" : addressName, "address[phone]" : phone, "address[region]" : addressRegion, "address[city]" : addressCity, "address[location][lat]" : locationLat, "address[location][lng]": locationLang, "address[address]" : addressMain]
            
            params.merge(dict: data)
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case .checkOutWithAddress(paymentType: let paymentType, addressID: let addressID, data: let data):
            
            var params = ["payment_type" : paymentType, "address_id" : addressID] as [String : Any]
            
            params.merge(dict: data)
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case .search(query: let query, page: let page, orderBy: let orderBy):
            return .requestParameters(parameters: ["search":query, "page":page, "orderBy": orderBy], encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: ApiConstants.main) else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .homePage:
            return ""
        case .newsPage:
            return "posts"
        case .newsItem(productId: let id):
            return "posts/\(id)"
        case .categoryPage:
            return "categories"
        case .categoryItems(sectionId: let sectionId):
            return  "categories/\(sectionId.sectionId)"
        case .productItem(productId: let productId):
            return  "product/\(productId)"
        case .login:
            return "oauth/login"
        case .verify:
            return "oauth/verify"
        case .logout:
            return "oauth/logout"
        case .profile, .updateProfile:
            return "profile"
        case .favourites:
            return "profile/favorites"
        case .addToFavourites(productId: let productID):
            return "product/\(productID)/favorite"
        case .removeFromFavourite(productId: let productID):
            return "product/\(productID)/favorite"
        case .addToCard, .getBasketItems:
            return "cart"
        case .getUserAddresses, .addAddress:
            return "profile/addresses"
        case .checkout, .checkOutWithAddress:
            return "checkout"
        case .deleteSpecificAddress(addressId: let addressId):
            return "profile/addresses/\(addressId)"
        case .updateSpecificAddress(addressId: let addressId):
            return "profile/addresses/\(addressId.addressId)"
        case .getSpecificAddress(addressId: let addressId):
            return "profile/addresses/\(addressId)"
        case .addComment(productId: let productId):
            return "product/\(productId.productId)/comments"
        case .orders:
            return "orders"
        case .orderDetails(productId: let id):
            return "orders/\(id)"
        case .deleteOrder(productId: let id):
            return "orders/\(id)"
        case .search:
            return "search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .homePage, .newsPage, .newsItem, .categoryPage, .categoryItems, .productItem, .profile, .favourites, .getUserAddresses, .getSpecificAddress, .orders, .orderDetails, .search:
            return .get
        case .login, .verify, .logout, .addToFavourites, .addToCard, .addAddress, .getBasketItems, .checkout, .checkOutWithAddress, .addComment:
            return .post
        case .removeFromFavourite, .deleteSpecificAddress, .deleteOrder:
            return .delete
        case .updateProfile, .updateSpecificAddress:
            return .put
        }
    }
    
    var headers: [String : String]? {
        
        var language: String = "ru"
        language = UserPreferences.shared.currentLanguage ?? "ru"
        
        switch self {
        case .profile, .favourites, .orders, .removeFromFavourite, .addToFavourites, .getUserAddresses, .productItem, .addComment, .search:
            guard let userToken = UserPreferences.shared.userToken else { return nil }
            let bearer = "Bearer \(userToken)"
            return ["Content-Type" : "application/json", "Authorization" : bearer, "Accept-Language" : language]
        case .addAddress, .checkout, .checkOutWithAddress, .updateProfile, .updateSpecificAddress:
            guard let userToken = UserPreferences.shared.userToken else { return nil }
            let bearer = "Bearer \(userToken)"
            return ["Content-Type" : "application/x-www-form-urlencoded", "Authorization" : bearer, "Accept-Language" : language]
        case .categoryItems, .logout, .deleteSpecificAddress, .getSpecificAddress, .orderDetails, .deleteOrder:
            guard let userToken = UserPreferences.shared.userToken else { return nil }
            let bearer = "Bearer \(userToken)"
            return ["Authorization" : bearer, "Accept-Language" : language]
        case .getBasketItems:
            return ["Content-Type": "application/x-www-form-urlencoded", "Accept-Language" : language]
        default:
            return ["Content-Type": "application/json", "Accept-Language" : language]
        }
    }
}
