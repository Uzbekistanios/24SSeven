
protocol ProductViewModelProtocol: AnyObject {
    func didUpdateProductItem()
}

class ProductViewModel {
    weak var delegate: ProductViewModelProtocol?
    
    fileprivate(set) var product: CategoryProductItem?
    fileprivate(set) var images: [CategoryImage]? = []
    fileprivate(set) var comments: [CategoryComment]? = []
    fileprivate(set) var similarProducts: [CategoryProductsRelated]? = []
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchMainProductItem(productId: Int) {
        networkManager.fetchProductItem(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.product = response
               
                strongSelf.images = response.images
                strongSelf.comments = response.comments
                strongSelf.similarProducts = response.productsRelated
              
                strongSelf.delegate?.didUpdateProductItem()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, productIndex: productId)
    }
}
