
import UIKit

class ViewGroupViewController : GenericViewController {
    
    let _view = ViewGroupView()
    var type: ViewGroupTypes
    
    var countOfNews : Int?
    var countOfFavs : Int?
    
    let viewModel = ViewGroupViewModel()
    let viewModelFavs = FavouritesViewModel()
    let addFavVM = AddToFavouriteViewModel()
    let removeFavVM = RemoveFromFavouriteViewModel()
    
    init(type: ViewGroupTypes) {
        self.type = type
        _view.type = type
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func loadView() {
        view = _view
    }
}

extension ViewGroupViewController {
    private func setupCollectionView() {
        
        viewModel.delegate = self
        viewModel.fetchNews()
        
        viewModelFavs.delegate = self
        viewModelFavs.fetchFavourites(page: 1)
        
        _view.collectionView.delegate = self
        _view.collectionView.dataSource = self
    }
}

//MARK: - UICollectionViewDataSource
extension ViewGroupViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch type {
        case .news:
            return countOfNews ?? 0
        case .favorites:
            return viewModelFavs.favouritesList?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch type {
        case .favorites:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseId, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell()}
            
            if let pagination = viewModelFavs.pagination {
                if countOfFavs == indexPath.row + 1 && pagination.nextPage != nil {
                    viewModelFavs.delegate = self
                    viewModelFavs.fetchFavourites(page: pagination.nextPage ?? 1)
                }
            }
            
            cell.delegate = self
            cell.cellModelFavs = viewModelFavs.favouritesList?[indexPath.item]
            return cell
        case .news:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.reuseId, for: indexPath) as? NewsCollectionViewCell else { return UICollectionViewCell() }
            cell.newsImageView.setImage(imageUrl: viewModel.items?[indexPath.row].image ?? "")
            cell.dateLabel.text = viewModel.items?[indexPath.row].createdAt
            cell.titleLabel.text = viewModel.items?[indexPath.row].name
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegate
extension ViewGroupViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch type {
        case .favorites:
            let navVC  = ProductViewController()
            navVC.productID = viewModelFavs.favouritesList?[indexPath.row].id
            self.navigationController?.pushViewController(navVC, animated: true)
        case .news:
            let navVC = NewsViewController()
            navVC.newsId = viewModel.items?[indexPath.row].id
            self.navigationController?.pushViewController(navVC, animated: true)
        }
    }
}

extension ViewGroupViewController : ProductCollectionViewCellProtocol {
    func didAddToFavorites(_ cell: ProductCollectionViewCell) {
        if cell.isFavorite ?? false == false {
            cell.isFavorite = true
            addFavVM.delegate = self
            addFavVM.addToFavourite(product: cell.productId ?? 0)
        } else {
            cell.isFavorite = false
            removeFavVM.delegate = self
            removeFavVM.removeFromFavourite(product: cell.productId ?? 0)
        }
    }
    
    func didAddToCart(_ cell: ProductCollectionViewCell) {
        guard let indexPath = self._view.collectionView.indexPath(for: cell) else { return }
        
        let basket = BasketModel()
        basket.id = viewModelFavs.items?[indexPath.row].id ?? 0
        basket.count = 1
        
        if let findedBasket = uiRealm.objects(BasketModel.self).filter({
            $0.id == self.viewModelFavs.items?[indexPath.row].id ?? 0
        }).first {
            basket.count += findedBasket.count
            findedBasket.deleteFromRealm()
        }
        
        self.simpleTextSnackBar(title: "added_to_basket".localized(using: "Localizable"))
        basket.writeToRealm()
    }
}

extension ViewGroupViewController : AddToFavouriteViewModelProtocol {
    func addToFavourite() {
        if AuthManager.shared.isAuthenticated() {
            simpleTextSnackBar(title: "added_to_basket".localized(using: "Localizable"))
        } else {
            snackBarForLogin()
        }
    }
}

extension ViewGroupViewController : RemoveFromFavouriteViewModelProtocol {
    func removeFromFavourite() {
        if AuthManager.shared.isAuthenticated() {
            simpleTextSnackBar(title: "remove_from_favorites".localized(using: "Localizable"))
        } else {
            snackBarForLogin()
        }

    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ViewGroupViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width/2.0 - 32, height: 260)
    }
}

extension ViewGroupViewController: ViewGroupViewModelProtocol {
    func didUpdateNews() {
        countOfNews = viewModel.items?.count
        _view.collectionView.reloadData()
    }
}

extension ViewGroupViewController: FavouritesViewModelProtocol {
    func updateFavItems() {
        countOfFavs = viewModelFavs.items?.count
        _view.collectionView.reloadData()
    }
}

extension ViewGroupViewController : AddToCardViewModelProtocol {
    func addToCard() {
        simpleTextSnackBar(title: "added_success".localized(using: "Localizable"))
    }
}
