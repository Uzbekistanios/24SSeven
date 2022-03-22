//
//  ViewAllView.swift
//  24SEVEN
//
//  Created by Islom on 04/02/21.
//

import UIKit

class ViewAllView : GenericView {
    
    let sortAndFilter = FilterHeaderView()
    
    var collectionView : UICollectionView!
    
    var sortOption: String? {
        didSet {
            guard let option = sortOption else { return }
            sortAndFilter.sortButton.setTitle(option, for: .normal)
        }
    }
    
    override init() {
        super.init()
        
        setupSearchBar()
        setupCollectionView()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ViewAllView {
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 9
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 12, right: 24)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseId)
    }
    
    private func style() {
        navBarView.title = "title_newProducts".localized(using: "Localizable")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
    }
    
    private func layout() {
        contentView.addSubview(sortAndFilter)
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            sortAndFilter.topAnchor.constraint(equalTo: searchVC.searchAndScanView.bottomAnchor, constant: 20),
            sortAndFilter.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sortAndFilter.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: sortAndFilter.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
