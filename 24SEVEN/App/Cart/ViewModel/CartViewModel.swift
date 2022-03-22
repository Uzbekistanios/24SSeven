
protocol CartViewModelProtocol: AnyObject {
    func didUpdateCheckoutPage()
}

class CartViewModel {
    weak var delegate: CartViewModelProtocol?
    
    fileprivate(set) var itemsCard: CardCheckoutItemCard?
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getCardInfo(param: [String:Any]) {
        networkManager.getItemsCart(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.itemsCard = response
                strongSelf.delegate?.didUpdateCheckoutPage()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, data: param)
    }
}
