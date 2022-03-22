
protocol AddToFavouriteViewModelProtocol: AnyObject {
    func addToFavourite()
}

class AddToFavouriteViewModel {
    weak var delegate: AddToFavouriteViewModelProtocol?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func addToFavourite(product: Int) {
        networkManager.addToFavourite(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
               print(response)
                strongSelf.delegate?.addToFavourite()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, productId: product)
    }
}
