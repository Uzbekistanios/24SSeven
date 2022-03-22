//
//  HomeCarouselViewController.swift
//  24SEVEN
//
//  Created by Islom on 02/02/21.
//

import UIKit
import SafariServices

class CarouselHomeController : UIViewController {
    
    var imageCountHome: Int?
    
    let carouselView : CarouselViewHome
    
    var images: [MainSlider]? = [] {
        didSet {
            imageCountHome = images?.count
            carouselView.collectionView.reloadData()
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.carouselView = CarouselViewHome()
        super.init(nibName: nil, bundle: nil)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func loadView() {
        view = carouselView
    }
}

extension CarouselHomeController {
    private func setup() {
        carouselView.collectionView.delegate = self
        carouselView.collectionView.dataSource = self
    }
}

//MARK: - UICollectionViewDataSource
extension CarouselHomeController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        carouselView.pageControl.numberOfPages = imageCountHome ?? 0
        return imageCountHome ?? 0
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselHomeCollectionViewCell.reuseId, for: indexPath) as? CarouselHomeCollectionViewCell else {return UICollectionViewCell()}
    
        cell.carouselImageView.contentMode = .scaleToFill
        cell.carouselImageView.setImage(imageUrl: images?[indexPath.row].image ?? "")
      
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension CarouselHomeController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if verifyUrl(urlString: images?[indexPath.row].link ?? "") == false {
            simpleTextSnackBar(title: "wrong_url".localized(using: "Localizable"))
        } else {
            guard let url = URL(string: images?[indexPath.row].link ?? "") else { return }
            let safariVc = SFSafariViewController(url: url)
            self.present(safariVc, animated: true, completion: nil)
        }
    }
    
    //MARK: - scrollViewDidScroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x/scrollView.frame.size.width
        carouselView.pageControl.currentPage = lround(Double(page))
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CarouselHomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 10, height: collectionView.frame.size.height)
    }
}
