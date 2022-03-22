
protocol OrderViewModelProtocol: AnyObject {
    func getUserOrders()
}

class OrderViewModel {
    weak var delegate: OrderViewModelProtocol?
    var favouritesList : [OrderItem]? = []
    fileprivate(set) var items: [OrderItem]? = []
    fileprivate(set) var pagination: OrderPagination?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
     
    func getUserOrders(type: String, page: Int) {
        networkManager.getUserOrders(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.items = response.items
                strongSelf.favouritesList?.append(contentsOf: response.items ?? [])
                strongSelf.pagination = response.pagination
                strongSelf.delegate?.getUserOrders()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, type: type, page: page)
    }
}
