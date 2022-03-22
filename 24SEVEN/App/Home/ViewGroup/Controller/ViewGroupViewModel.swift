
protocol ViewGroupViewModelProtocol: AnyObject {
    func didUpdateNews()
}

class ViewGroupViewModel {
   
    weak var delegate: ViewGroupViewModelProtocol?
    
    fileprivate(set) var pagination: NewsPagination?
    fileprivate(set) var items: [NewsItem]? = []
  
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchNews() {
        networkManager.fetchNews { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.pagination = response.pagination
                strongSelf.items = response.items
                strongSelf.delegate?.didUpdateNews()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
