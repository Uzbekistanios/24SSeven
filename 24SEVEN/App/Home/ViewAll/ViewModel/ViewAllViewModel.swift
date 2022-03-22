
protocol ViewAllViewModelProtocol: AnyObject {
    func didUpdateViewAllView()
}

class ViewAllViewModel {
    weak var delegate: ViewAllViewModelProtocol?
    
    var itemsCategory : [ViewAllItem]? = []
    fileprivate(set) var items: [ViewAllItem]? = []
    fileprivate(set) var pagination: ViewAllPagination?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchCategoryItems(categorySection: Int, page: Int, orderBy: String) {
        networkManager.fetchCategoryItems(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                print(response)
                strongSelf.items = response.items
                strongSelf.itemsCategory?.append(contentsOf: response.items ?? [])
                strongSelf.pagination = response.pagination
                strongSelf.delegate?.didUpdateViewAllView()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, productSection: categorySection, page: page, orderBy: orderBy)
    }
}
