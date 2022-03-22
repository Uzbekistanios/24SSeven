
protocol FavouritesViewModelProtocol: AnyObject {
    func updateFavItems()
}

class FavouritesViewModel {
    var favouritesList : [FavoritesItem]? = []
    weak var delegate: FavouritesViewModelProtocol?
    
    fileprivate(set) var items: [FavoritesItem]? = []
    fileprivate(set) var pagination: FavoritesPagination?
    
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchFavourites(page: Int) {
        networkManager.fetchFavouriteItems(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.items = response.items
                strongSelf.favouritesList?.append(contentsOf: response.items ?? [])
                strongSelf.pagination = response.pagination
                strongSelf.delegate?.updateFavItems()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, page: page)
    }
}
