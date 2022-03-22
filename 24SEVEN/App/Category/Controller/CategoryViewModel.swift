
protocol CategoryViewModelProtocol: AnyObject {
    func didUpdateCategoryPage()
}

class CategoryViewModel {
    weak var delegate: CategoryViewModelProtocol?
    
    fileprivate(set) var categories: [CategoryModelElement]? = []

    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchHomePage() {
        networkManager.fetchCategoryPage { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.categories = response
                strongSelf.delegate?.didUpdateCategoryPage()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
