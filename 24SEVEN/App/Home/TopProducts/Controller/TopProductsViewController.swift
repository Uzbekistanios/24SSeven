//
//  TopProductsViewController.swift
//  24SEVEN
//
//  Created by Islom on 03/02/21.
//

import UIKit

class TopProductsViewController: UIViewController {
    
    let _view = TopProductsView()
    
    var productViewModel : [CategoryProductsRelated]? {
        didSet {
            _view.productViewModel = productViewModel
        }
    }
    
    let addFavVM = AddToFavouriteViewModel()
    let removeFavVM = RemoveFromFavouriteViewModel()
    
    var items: MainCompilation? {
        didSet {
            _view.items = items
        }
    }
    
    var posts: [MainPost]? {
        didSet {
            _view.posts = posts
        }
    }
    
    var type: TopProductTypes
    
    init(type: TopProductTypes) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
        _view.type = type
        setup()
        viewAll()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = _view
    }
    
}

extension TopProductsViewController {
    private func setup() {
        _view.collectionView.delegate = self
        _view.collectionView.dataSource = self
    }
    
    private func viewAll() {
        _view.headerView.viewAllClosure = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.pushViewController(self.type.viewAllVC, animated: true)
        }
    }
}

//MARK: - UICollectionViewDelegate
extension TopProductsViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch type {
        case .news:
            let navController = NewsViewController()
            navController.newsId = posts?[indexPath.row].id
            self.navigationController?.pushViewController(navController, animated: true)
        case .products:
            let navController = ProductViewController()
            if items?.products?[indexPath.row].id != nil {
                navController.productID = items?.products?[indexPath.row].id
            } else {
                navController.productID = productViewModel?[indexPath.row].id
            }
            self.navigationController?.pushViewController(navController, animated: true)
        }
    }
}


//MARK: - UICollectionViewDataSource
extension TopProductsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _view.itemsCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch type {
        case .products:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseId, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
            
            cell.cellModelOther = productViewModel?[indexPath.row]
            cell.delegate = self
            cell.cellModel = items?.products?[indexPath.item]
            
            return cell
        case .news:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.reuseId, for: indexPath) as? NewsCollectionViewCell else { return UICollectionViewCell()}
           
            cell.newsImageView.setImage(imageUrl: posts?[indexPath.row].image ?? "")
            cell.titleLabel.text = posts?[indexPath.row].name
            cell.dateLabel.text = posts?[indexPath.row].createdAt
            
            return cell
        }
    }
}

extension TopProductsViewController : ProductCollectionViewCellProtocol {
    func didAddToFavorites(_ cell: ProductCollectionViewCell) {
        
        if AuthManager.shared.isAuthenticated() {
            if cell.isFavorite ?? false == false{
                cell.isFavorite = true
                addFavVM.addToFavourite(product: cell.productId ?? 0)
                addFavVM.delegate = self
            } else {
                cell.isFavorite = false
                removeFavVM.removeFromFavourite(product: cell.productId ?? 0)
                removeFavVM.delegate = self
            }
        } else {
            snackBarForLogin()
        }
    }
    
    func didAddToCart(_ cell: ProductCollectionViewCell) {
        guard let indexPath = self._view.collectionView.indexPath(for: cell) else { return }
        
        let basket = BasketModel()
        
        if productViewModel?[indexPath.row].id != nil {
            basket.id = productViewModel?[indexPath.row].id ?? 0
        } else {
            basket.id = items?.products?[indexPath.row].id ?? 0
        }
        
        basket.count = 1
        
        if let findedBasket = uiRealm.objects(BasketModel.self).filter({
            $0.id == self.productViewModel?[indexPath.row].id ?? 0
        }).first {
            basket.count += findedBasket.count
            findedBasket.deleteFromRealm()
        }
        
        self.simpleTextSnackBar(title: "added_to_basket".localized(using: "Localizable"))
        basket.writeToRealm()
    }
}

extension TopProductsViewController : AddToFavouriteViewModelProtocol {
    func addToFavourite() {
        simpleTextSnackBar(title: "added_to_favorites".localized(using: "Localizable"))
    }
}

extension TopProductsViewController : RemoveFromFavouriteViewModelProtocol {
    func removeFromFavourite() {
        simpleTextSnackBar(title: "remove_from_favorites".localized(using: "Localizable"))
    }
}


//MARK: - UICollectionViewDelegateFlowLayout
extension TopProductsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width/2.0 - 20, height: collectionView.bounds.height - 20)
    }
}


