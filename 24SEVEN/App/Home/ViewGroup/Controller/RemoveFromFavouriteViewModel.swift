
protocol RemoveFromFavouriteViewModelProtocol: AnyObject {
    func removeFromFavourite()
}

class RemoveFromFavouriteViewModel {
    weak var delegate: RemoveFromFavouriteViewModelProtocol?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func removeFromFavourite(product: Int) {
        networkManager.removeFromFavourite(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                print(response)
                strongSelf.delegate?.removeFromFavourite()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, productId: product)
    }
}
