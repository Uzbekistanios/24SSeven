
import Moya
import UIKit

class NetworkManager: Networkable {
    
    var provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
    
    func fetchHomePage(completion: @escaping (Result<MainCatalogShowModel, Error>) -> ()) {
        request(target: .homePage, completion: completion)
    }
    
    func fetchNews(completion: @escaping (Result<NewsModel, Error>) -> ()) {
        request(target: .newsPage, completion: completion)
    }
    
    func fetchItemNews(completion: @escaping (Result<NewsItemNewsModel, Error>) -> (), productIdItem: Int) {
        request(target: .newsItem(productId: productIdItem), completion: completion)
    }
    
    func fetchCategoryPage(completion: @escaping (Result<CategoryModel, Error>) -> ()) {
        request(target: .categoryPage, completion: completion)
    }
    
    func fetchCategoryItems(completion: @escaping (Result<ViewAllCategoryItem, Error>) -> (), productSection: Int, page: Int, orderBy: String) {
        request(target: .categoryItems(sectionId: productSection, page: page, orderBy: orderBy), completion: completion)
    }
    
    func fetchProductItem(completion: @escaping (Result<CategoryProductItem, Error>) -> (), productIndex: Int) {
        request(target: .productItem(productId: productIndex), completion: completion)
    }
    
    // MARK:  login part
    func loginPhone(completion: @escaping (Result<LoginResponse, Error>) -> (), phone: Int) {
        request(target: .login(phone: phone.description), completion: completion)
    }
    
    // MARK:  logout part
    func logout(completion: @escaping (Result<DefaultResponse, Error>) -> ()) {
        request(target: .logout, completion: completion)
    }
    
    func verifyPhone(completion: @escaping (Result<LoginVerifyModel, Error>) -> (), phone: Int, verifyCode: Int) {
        request(target: .verify(phone: phone, code: verifyCode), completion: completion)
    }
    
    func fetchUserInfo(completion: @escaping (Result<ProfileUser, Error>) -> ()) {
        request(target: .profile, completion: completion)
    }
    
    func fetchFavouriteItems(completion: @escaping (Result<FavoritesUserFavourites, Error>) -> (), page: Int) {
        request(target: .favourites(page: page), completion: completion)
    }
    
    func addToFavourite(completion: @escaping (Result<AddUserFavourites, Error>) -> (), productId: Int) {
        request(target: .addToFavourites(productId: productId), completion: completion)
    }
    
    func addItemComment(completion: @escaping (Result<AddComment, Error>) -> (), productId: Int, firstName: String, body: String) {
        request(target: .addComment(productId: productId, firstName: firstName, body: body), completion: completion)
    }
    
    func removeFromFavourite(completion: @escaping (Result<DefaultResponse,Error>) -> (), productId: Int) {
        request(target: .removeFromFavourite(productId: productId), completion: completion)
    }
    
    func addToCard(completion: @escaping (Result<CardCheckoutItemCard, Error>) -> (), productId: Int) {
        request(target: .addToCard(productId: productId), completion: completion)
    }
    
    func getItemsCart(completion: @escaping (Result<CardCheckoutItemCard, Error>) -> (), data: [String : Any]) {
        request(target: .getBasketItems(data: data), completion: completion)
    }
    
    // MARK:  get address
    func fetchUserAddresses(completion: @escaping (Result<AddressModel, Error>) -> (), page: Int) {
        request(target: .getUserAddresses(page: page), completion: completion)
    }
    
    // MARK:  get address
    func profileUpdate(completion: @escaping (Result<ProfileUser, Error>) -> (), firstName: String, secondName: String, birthDate: String, gender: Int) {
        request(target: .updateProfile(firstName: firstName, secondName: secondName, birthDate: birthDate, gender: gender), completion: completion)
    }
    
    func addNewAddress(completion: @escaping (Result<AddAdress, Error>) -> (), name: String, address: String, city: String, region: String, locationLat: String, locationLang: String, phone: String) {
        request(target: .addAddress(name: name, address: address, city: city, region: region, locationLat: locationLat, locationLang: locationLang, phone: phone), completion: completion)
    }
    
    func checkoutProcess(completion: @escaping (Result<CheckoutModel, Error>) -> (), paymentType:String, addressName:String, addressMain: String, addressCity:String, addressRegion:String, phone:String, locationLat:String, locationLang:String, data: [String : String]) {
        request(target: .checkout(paymentType: paymentType, data: data, addressName: addressName, addressMain: addressMain, addressCity: addressCity, addressRegion: addressRegion, phone: phone, locationLat: locationLat, locationLang: locationLang), completion: completion)
    }
    
    func checkoutProcessWithAddress(completion: @escaping (Result<CheckoutModel, Error>) -> (), paymentType:String, addressId:Int, data: [String : String]) {
        request(target: .checkOutWithAddress(paymentType: paymentType, addressID: addressId, data: data), completion: completion)
    }
    
    func getAddressInfo(completion: @escaping (Result<EditAddress, Error>) -> (), addressId: Int) {
        request(target: .getSpecificAddress(addressId: addressId), completion: completion)
    }
    
    func deleteAddressInfo(completion: @escaping (Result<DefaultResponse, Error>) -> (), addressId: Int) {
        request(target: .deleteSpecificAddress(addressId: addressId), completion: completion)
    }
    
    func updateAddress(completion: @escaping (Result<EditAddress, Error>) -> (), addressId: Int, name: String, address: String, city: String, region: String, locationLat: String, locationLang: String, phone: String) {
        request(target: .updateSpecificAddress(addressId: addressId, name: name, address: address, city: city, region: region, locationLat: locationLat, locationLang: locationLang, phone: phone), completion: completion)
    }
    
    func getUserOrders(completion: @escaping (Result<OrdersModel, Error>) -> (), type: String, page: Int) {
        request(target: .orders(type: type, page: page), completion: completion)
    }
    
    func getOrderItem(completion: @escaping (Result<OrdersDetail, Error>) -> (), orderID : Int) {
        request(target: .orderDetails(productId: orderID), completion: completion)
    }
    
    func cancelOrder(completion: @escaping (Result<DefaultResponse, Error>) -> (), productId: Int) {
        request(target: .deleteOrder(productId: productId), completion: completion)
    }
    
    func searchItems(completion: @escaping (Result<SearchResultsModel, Error>) -> (), query: String, page: Int, orderBy: String) {
        request(target: .search(query: query, page: page, orderBy: orderBy), completion: completion)
    }
    
    init(provider: MoyaProvider<API>){
        self.provider = provider
    }
    
    convenience init(){
        let networkActivityClosure: NetworkActivityPlugin.NetworkActivityClosure = { (activity, _) in
            switch activity {
            case .began:
                DispatchQueue.main.async {
                    MyCustomLoader.show(title: "loading".localized(using: "Localizable"), animated: true)
                }
            case .ended:
                DispatchQueue.main.async {
                    MyCustomLoader.hide()
                }
            }
        }
        
        var plugins : [PluginType] = []
        
        let networkActivityPlugin = NetworkActivityPlugin(networkActivityClosure: networkActivityClosure)
        plugins.append(networkActivityPlugin)
        
        let networkLogger = NetworkLoggerPlugin()
        plugins.append(networkLogger)
        
        let provider = MoyaProvider<API>(plugins: plugins)
        self.init(provider: provider)
    }
}

private extension NetworkManager {
    private func request<T: Decodable>(target: API, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                if let model = DefaultResponse() as? T, response.request?.method == .delete {
                    completion(.success(model))
                } else {
                    do {
                        let results = try JSONDecoder().decode(T.self, from: response.data)
                        completion(.success(results))
                    } catch let error {
                        completion(.failure(error))
                    }
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
