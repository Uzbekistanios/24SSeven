
import UIKit
import SideMenu

class ViewAllViewController : GenericViewController {
    private var viewModel = ViewAllViewModel()
    let addFavVM = AddToFavouriteViewModel()
    let removeFavVM = RemoveFromFavouriteViewModel()
    let _view = ViewAllView()
    var numberOfItems: Int?
    var categoryId: Int?
    var didSelectFilterIndex = 0
    
    var navBarTitle: String?{
        didSet {
            _view.navBarView.title = navBarTitle
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        view = _view
    }
}

extension ViewAllViewController {
    private func setup() {
        
        viewModel.delegate = self
        viewModel.fetchCategoryItems(categorySection: categoryId ?? 0, page: 1, orderBy: "popular")
        
        _view.collectionView.delegate = self
        _view.collectionView.dataSource = self
        
        displaySort()
        displayFilter()
    }
    
    private func displaySort() {
        _view.sortAndFilter.showSort = { [weak self] in
            guard let self = self else { return }
            
            let sortVC = SortViewController()
            sortVC.modalPresentationStyle = .custom
            sortVC.transitioningDelegate = self
            sortVC.delegate = self
            self.present(sortVC, animated: true)
        }
    }
    
    private func displayFilter() {
        _view.sortAndFilter.showFilter = { [weak self] in
            guard let self = self else { return }
            self.simpleTextSnackBar(title: "not_available".localized(using: "Localizable"))
//            let filterMenuVC = SideMenuNavigationController(rootViewController: FilterViewController())
//            filterMenuVC.presentationStyle = .menuSlideIn
//            filterMenuVC.enableSwipeToDismissGesture = false
//            filterMenuVC.menuWidth = UIScreen.main.bounds.width * 0.8
//            filterMenuVC.delegate = self
//            filterMenuVC.navigationBar.isHidden = true
//            self.present(filterMenuVC, animated: true, completion: nil)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension ViewAllViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemsCategory?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseId, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        
        if let pagination = viewModel.pagination {
            if numberOfItems == indexPath.row + 1 && pagination.nextPage != nil {
                viewModel.delegate = self
                viewModel.fetchCategoryItems(categorySection: categoryId ?? 0, page:  pagination.nextPage ?? 1, orderBy: MockData.sortTypes[didSelectFilterIndex])
            }
        }
        
        cell.delegate = self
        cell.cellModelCategory = viewModel.itemsCategory?[indexPath.row]
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension ViewAllViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductViewController()
        vc.productID = viewModel.itemsCategory?[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ViewAllViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width/2.0 - 32, height: collectionView.bounds.width * 0.75 - 10)
    }
}

extension ViewAllViewController : ProductCollectionViewCellProtocol {
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
        basket.id = viewModel.itemsCategory?[indexPath.row].id ?? 0
        basket.count = 1
        
        if let findedBasket = uiRealm.objects(BasketModel.self).filter({
            $0.id == self.viewModel.itemsCategory?[indexPath.row].id ?? 0
        }).first {
            basket.count += findedBasket.count
            findedBasket.deleteFromRealm()
        }
        
        self.simpleTextSnackBar(title: "added_to_basket".localized(using: "Localizable"))
        basket.writeToRealm()
    }
}

extension ViewAllViewController : AddToFavouriteViewModelProtocol {
    func addToFavourite() {
        if AuthManager.shared.isAuthenticated() {
            simpleTextSnackBar(title: "added_to_favorites".localized(using: "Localizable"))
        } else {
            snackBarForLogin()
        }
      
    }
}

extension ViewAllViewController : RemoveFromFavouriteViewModelProtocol {
    func removeFromFavourite() {
        if AuthManager.shared.isAuthenticated() {
           simpleTextSnackBar(title: "remove_from_favorites".localized(using: "Localizable"))
        } else {
            snackBarForLogin()
        }
    }
}

extension ViewAllViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension ViewAllViewController: ViewAllViewModelProtocol {
    func didUpdateViewAllView() {
        numberOfItems = viewModel.items?.count
        _view.collectionView.reloadData()
    }
}

extension ViewAllViewController : SortViewControllerDelegate {
    func didSelectSortOption(option: String, index: Int) {
        _view.sortOption = option
        viewModel.itemsCategory = []
        viewModel.delegate = self
        didSelectFilterIndex = index
        viewModel.fetchCategoryItems(categorySection: categoryId ?? 0,
                                     page: 1,
                                     orderBy: MockData.sortTypes[didSelectFilterIndex])
    }
}

extension ViewAllViewController: SideMenuNavigationControllerDelegate, UINavigationControllerDelegate {
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        
        UIView.animate(withDuration: menu.presentDuration) {
            self.view.alpha = 0.4
            self.tabBarController?.tabBar.alpha = 0.4
        }
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        UIView.animate(withDuration: menu.dismissDuration) {
            self.view.alpha = 1
            self.tabBarController?.tabBar.alpha = 1
        }
    }
}
