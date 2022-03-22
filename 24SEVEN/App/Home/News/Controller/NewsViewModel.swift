
protocol NewsViewModelProtocol: AnyObject {
    func didUpdateNewsItem()
}

class NewsViewModel {
    weak var delegate: NewsViewModelProtocol?
    
    fileprivate(set) var newsItem: NewsItemNewsModel?
     
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchMainNewsItem(productId: Int) {
        networkManager.fetchItemNews(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.newsItem = response
                strongSelf.delegate?.didUpdateNewsItem()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, productIdItem: productId)
    }
}
