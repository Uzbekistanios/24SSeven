
protocol CheckoutWithIDViewModelProtocol: AnyObject {
    func checkoutWithId()
}

class CheckoutWithIDViewModel {
    weak var delegate: CheckoutWithIDViewModelProtocol?
    
    fileprivate(set) var response: CheckoutModel?
   
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
   
    func checkoutWithAddress(paymentType: String, addressId: Int, data: [String : String]) {
        networkManager.checkoutProcessWithAddress(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.response = response
                strongSelf.delegate?.checkoutWithId()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, paymentType: paymentType, addressId: addressId, data: data)
    }
}
