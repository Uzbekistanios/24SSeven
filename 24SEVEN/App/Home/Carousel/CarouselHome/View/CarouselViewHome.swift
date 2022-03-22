//
//  HomeCarouselView.swift
//  24SEVEN
//
//  Created by Islom on 02/02/21.
//

import UIKit

class CarouselViewHome : IBView {
    
    var collectionView : UICollectionView!
    let pageControl = UIPageControl()
    
    override init() {
        super.init()
        setupCollectionView()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CarouselHomeCollectionViewCell.self, forCellWithReuseIdentifier: CarouselHomeCollectionViewCell.reuseId)
    }
    
    private func style() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.cornerRadius = 10.0
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.alwaysBounceHorizontal = true
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = UIColor.defaultOrange
        pageControl.numberOfPages = 3
    }
    
    private func layout() {
        addSubview(collectionView)
        addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 125),
            
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            pageControl.heightAnchor.constraint(equalToConstant: 10),
        ])
    }
}
