//
//  OrderView.swift
//  24SEVEN
//
//  Created by Islom on 13/02/21.
//

import UIKit

class OrderView : GenericView {
    
    var collectionView : UICollectionView!
    
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    let orderViewControllers = [
        WaitingViewController(),
        ActiveViewController(),
        DeliveredViewController()
    ]
    
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
        collectionView.register(OrderTypeCollectionViewCell.self, forCellWithReuseIdentifier: OrderTypeCollectionViewCell.reuseId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func style() {
        collectionView.backgroundColor = .clear
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        navBarView.title = "my_orders".localized(using: "Localizable")
    }
    
    private func layout() {
        contentView.addSubview(collectionView)
        contentView.addSubview(pageViewController.view)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 35),
            
            pageViewController.view.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 24),
            pageViewController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28)
        ])
    }
}
