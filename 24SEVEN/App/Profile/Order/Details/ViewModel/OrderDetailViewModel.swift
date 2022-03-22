
protocol OrderDetailViewModelProtocol: AnyObject {
    func getOrderDetailItem()
}

class OrderDetailViewModel {
    weak var delegate: OrderDetailViewModelProtocol?
    
    fileprivate(set) var orderItem: OrdersDetail?
    fileprivate(set) var orderProducts: [OrderDetailProduct]? = []
     
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getOrderDetail(orderID: Int) {
        networkManager.getOrderItem(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.orderItem = response
                strongSelf.orderProducts = response.products
                strongSelf.delegate?.getOrderDetailItem()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, orderID: orderID)
    }
}
