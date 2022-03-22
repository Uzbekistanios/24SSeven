//
//  HomeCarouselViewController.swift
//  24SEVEN
//
//  Created by Islom on 02/02/21.
//

import UIKit

class CarouselViewController : UIViewController {
    
    var numberOfImages: Int?
    let addFavVM = AddToFavouriteViewModel()
    let removeFavVM = RemoveFromFavouriteViewModel()
    
    var imagesViewModel: [CategoryImage]? = [] {
        didSet {
            numberOfImages = imagesViewModel?.count
        }
    }
    
    var productViewModel : CategoryProductItem? {
        didSet {
            if productViewModel?.isFavorite ?? false {
                carouselView.isFavorite = true
            }
        }
    }
    let carouselView : CarouselView
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.carouselView = CarouselView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTargets()
    }
    
    override func loadView() {
        super.loadView()
        view = carouselView
    }
}

extension CarouselViewController {
    private func setup() {
        carouselView.collectionView.delegate = self
        carouselView.collectionView.dataSource = self
    }
    
    private func setupTargets() {
        carouselView.favouriteHandler = { [weak self] in
            guard let self = self else { return }
            if self.carouselView.isFavorite ?? false == false{
                self.addFavVM.delegate = self
                self.addFavVM.addToFavourite(product: self.productViewModel?.id ?? 0)
            } else {
                self.removeFavVM.delegate = self
                self.removeFavVM.removeFromFavourite(product: self.productViewModel?.id ?? 0)
            }
        }
    }
}


extension CarouselViewController : AddToFavouriteViewModelProtocol {
    func addToFavourite() {
        if AuthManager.shared.isAuthenticated() {
            carouselView.isFavorite = true
            simpleTextSnackBar(title: "added_to_favorites".localized(using: "Localizable"))
        } else {
            snackBarForLogin()
        }
      
    }
}

extension CarouselViewController : RemoveFromFavouriteViewModelProtocol {
    func removeFromFavourite() {
        if AuthManager.shared.isAuthenticated() {
            carouselView.isFavorite = false
            simpleTextSnackBar(title: "remove_from_favorites".localized(using: "Localizable"))
        } else {
            snackBarForLogin()
        }
    }
}

//MARK: - UICollectionViewDataSource
extension CarouselViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        carouselView.pageControl.numberOfPages = numberOfImages ?? 0
        return numberOfImages ?? 0
    }
    	
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.reuseId, for: indexPath) as? CarouselCollectionViewCell else {return UICollectionViewCell()}
    
        if productViewModel?.discountPercent == 0 {
            cell.discountView.isHidden = true
        } else {
            cell.discountView.discountLabel.text = "\(productViewModel?.discountPercent?.description ?? "0")%"
        }
       
        cell.carouselImageView.setImage(imageUrl: imagesViewModel?[indexPath.row].path ?? "")
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension CarouselViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    //MARK: - scrollViewDidScroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x/scrollView.frame.size.width
        carouselView.pageControl.currentPage = lround(Double(page))
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CarouselViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 10, height: collectionView.frame.size.height)
    }
}

