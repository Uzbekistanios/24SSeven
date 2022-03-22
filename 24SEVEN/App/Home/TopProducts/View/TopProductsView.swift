//
//  TopProductsView.swift
//  24SEVEN
//
//  Created by Islom on 03/02/21.
//

import UIKit

class TopProductsView : IBView {
    var itemsCount: Int?
    
    var productViewModel : [CategoryProductsRelated]? {
        didSet {
            itemsCount = productViewModel?.count ?? 0
            collectionView.reloadData()
            headerView.title = "Похожие продукты"
        }
    }
    
    var items: MainCompilation? {
        didSet {
            headerView.title = items?.title
            itemsCount = items?.products?.count ?? 0
        }
    }
    
    var posts: [MainPost]? {
        didSet {
            itemsCount = posts?.count ?? 0
        }
    }
    
    let headerView = ProductHeaderView()
    var collectionView: UICollectionView!
    var collectionViewHeightAnchor : NSLayoutConstraint!
    var multiplierHeight: CGFloat = 0.75
    
    var type: TopProductTypes! {
        didSet {
            guard let type = type else { return }
            switch type {
            case .products:
                headerView.title = "new_items".localized(using: "Localizable")
            case .news:
                headerView.title = "news".localized(using: "Localizable")
            }
        }
    }
    
    override init() {
        super.init()
        
        setupCollectionView()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 9
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 16)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseId)
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.reuseId)
    }
    
    private func style() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
    }
    
    private func layout() {
        addSubview(headerView)
        addSubview(collectionView)
        
        collectionViewHeightAnchor = collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: multiplierHeight )
      
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionViewHeightAnchor,
        ])
    }
}

