
protocol SearchResultsViewModelProtocol: AnyObject {
    func getSearchedItems()
}

class SearchResultsViewModel {
   
    weak var delegate: SearchResultsViewModelProtocol?
    
    var searchedItems : [searchItem]? = []
    fileprivate(set) var pagination: searchPagination?
    fileprivate(set) var items: [searchItem]? = []
  
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getSearchedResult(query: String, page: Int, orderBy: String) {
        networkManager.searchItems(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.pagination = response.pagination
                strongSelf.items = response.items
                strongSelf.searchedItems?.append(contentsOf: response.items ?? [])
                strongSelf.delegate?.getSearchedItems()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, query: query, page: page, orderBy: orderBy)
    }
}
