
protocol CheckoutViewModelProtocol: AnyObject {
    func checkout()
}

class CheckoutViewModel {
    weak var delegate: CheckoutViewModelProtocol?
    
    fileprivate(set) var response: CheckoutModel?
   
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
   
    func checkoutProcess(paymentType:String, addressName:String, addressMain: String, addressCity:String, addressRegion:String, phone:String, locationLat:String, locationLang:String, data: [String : String]) {
        networkManager.checkoutProcess(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.response = response
                strongSelf.delegate?.checkout()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, paymentType: paymentType, addressName: addressName, addressMain: addressMain, addressCity: addressCity, addressRegion: addressRegion, phone: phone, locationLat: locationLat, locationLang: locationLang, data: data)
    }
}
