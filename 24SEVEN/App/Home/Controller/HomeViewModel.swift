
protocol HomeViewModelProtocol: AnyObject {
    func didUpdateHomePage()
}

class HomeViewModel {
    weak var delegate: HomeViewModelProtocol?
    
    fileprivate(set) var sliders: [MainSlider]? = []
    fileprivate(set) var compilitions: [MainCompilation]? = []
    fileprivate(set) var postsHome: [MainPost]? = []
    
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchHomePage() {
        networkManager.fetchHomePage { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.sliders = response.sliders
                strongSelf.compilitions = response.compilations
                strongSelf.postsHome = response.posts
                strongSelf.delegate?.didUpdateHomePage()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
