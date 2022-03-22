//
//  SearchResultView.swift
//  24SEVEN
//
//  Created by Islom on 20/02/21.
//

import UIKit

class SearchResultView : GenericView {
    
    var collectionView: UICollectionView!

    override init() {
        super.init()

        setupSearchBar()
        setupSearchView()
        
        navBarTitle()
        setupCollectionView()
        layout()
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupSearchView() {
        searchVC.searchAndScanView.searchTextField.voiceButton.isUserInteractionEnabled = true
        NSLayoutConstraint.activate([
            searchVC.searchAndScanView.searchTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
       
        searchVC.searchAndScanView.favoriteButton.isHidden = true
        searchVC.searchAndScanView.scanButton.isHidden = true
        
        UIView.animate(withDuration: 0.4) {
            self.layoutIfNeeded()
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 9
        layout.sectionInset = UIEdgeInsets(top: 12, left: 22, bottom: 12, right: 22)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseId)
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.reuseId)
    }
    
    private func style() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
    }
    
    private func navBarTitle() {
        navBarView.title = "search".localized(using: "Localizable")
    }
    
    private func layout() {
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
