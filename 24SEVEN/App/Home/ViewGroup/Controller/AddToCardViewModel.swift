
protocol AddToCardViewModelProtocol: AnyObject {
    func addToCard()
}

class AddToCardViewModel {
    weak var delegate: AddToCardViewModelProtocol?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func addToCardAction(product: Int) {
        networkManager.addToCard(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                print(response)
                strongSelf.delegate?.addToCard()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, productId: product)
    }
}
