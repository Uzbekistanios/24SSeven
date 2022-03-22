
protocol DeleteOrderViewModelProtocol: AnyObject {
    func cancelOrder()
}

class DeleteOrderViewModel {
  
    weak var delegate: DeleteOrderViewModelProtocol?

    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func cancelOrder(orderID: Int) {
        networkManager.cancelOrder(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(_):
                strongSelf.delegate?.cancelOrder()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, productId: orderID)
    }
}
