
protocol GetAddressViewModelProtocol: AnyObject {
    func getAddress()
}

class GetAddressViewModel {
    var favouritesList : [FavoritesItem]? = []
    weak var delegate: GetAddressViewModelProtocol?
    
    fileprivate(set) var item: EditAddress?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getAddress(addressID: Int) {
        networkManager.getAddressInfo(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.item = response
                strongSelf.delegate?.getAddress()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, addressId: addressID)
    }
}
