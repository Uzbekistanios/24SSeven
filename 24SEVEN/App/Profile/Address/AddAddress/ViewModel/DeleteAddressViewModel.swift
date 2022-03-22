
protocol DeleteAddressViewModelProtocol: AnyObject {
    func deleteAddress()
}

class DeleteAddressViewModel {
    var favouritesList : [FavoritesItem]? = []

    weak var delegate: DeleteAddressViewModelProtocol?

    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getAddress(addressID: Int) {
        networkManager.deleteAddressInfo(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(_):
                strongSelf.delegate?.deleteAddress()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, addressId: addressID)
    }
}
