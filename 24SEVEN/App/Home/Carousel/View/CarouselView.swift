//
//  HomeCarouselView.swift
//  24SEVEN
//
//  Created by Islom on 02/02/21.
//

import UIKit

class CarouselView : IBView {
    
    var collectionView : UICollectionView!
    let pageControl = UIPageControl()
    let favoriteButton = UIButton.makeButton(imageName: Constants.notFavorite)
    
    var favouriteHandler: (() -> Void)?
    
    var isFavorite: Bool? {
        didSet {
            guard let isFavorite = isFavorite else { return }
            if isFavorite {
                favoriteButton.setImage(UIImage(named: Constants.favorite), for: .normal)
                favoriteButton.tintColor = UIColor.defaultOrange
            } else {
                favoriteButton.setImage(UIImage(named: Constants.notFavorite), for: .normal)
                favoriteButton.tintColor = UIColor.defaultOrange
            }
        }
    }
    
    override init() {
        super.init()
        setupCollectionView()
        style()
        layout()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: CarouselCollectionViewCell.reuseId)
    }
    
    private func addTarget() {
        favoriteButton.addTarget(self, action: #selector(favouriteAction), for: .primaryActionTriggered)
    }
    
    @objc func favouriteAction() {
        favouriteHandler?()
    }
    
    private func style() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.cornerRadius = 10.0
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.alwaysBounceHorizontal = true
        favoriteButton.tintColor = .systemGray
        favoriteButton.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = UIColor.defaultOrange
        pageControl.numberOfPages = 5
    }
    
    private func layout() {
        addSubview(collectionView)
        addSubview(pageControl)
        addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 10),
            
            collectionView.heightAnchor.constraint(equalToConstant: 166),
            collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -10),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            favoriteButton.topAnchor.constraint(equalTo: topAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
