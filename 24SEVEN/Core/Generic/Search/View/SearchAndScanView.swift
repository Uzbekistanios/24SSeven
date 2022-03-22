//
//  SearchAndScanView.swift
//  24SEVEN
//
//  Created by Islom on 01/02/21.
//

import UIKit

class SearchAndScanView : IBView {
    
    var searchTextField = SearchTextField()
    
    var scanButton = UIButton.makeButton(imageName: Constants.scanner,cornerRadius: 24.0)
    
    var favoriteButton = UIButton.makeButton(imageName: Constants.favorite, cornerRadius: 24.0)
    
    var searchTextFieldTrailngToScanButtonAnchor : NSLayoutConstraint!
    
    var searchTextFieldTrailngToSuperAnchor : NSLayoutConstraint!
    
    var favoriteClosure: (() -> Void)?
    
    var scanClosure: (() -> Void)?
    
    var searchClosure: (() -> Void)?
    
    override init() {
        super.init()
        
        style()
        layout()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        scanButton.tintColor = UIColor.defaultOrange
        scanButton.backgroundColor = UIColor.mainSubviewColor
        
        favoriteButton.tintColor = UIColor.defaultOrange
        favoriteButton.backgroundColor = UIColor.mainSubviewColor
    }
    
    private func layout() {
        addSubview(searchTextField)
        addSubview(scanButton)
        addSubview(favoriteButton)
        
        searchTextFieldTrailngToScanButtonAnchor = searchTextField.trailingAnchor.constraint(equalTo: scanButton.leadingAnchor, constant: -15)
        
        searchTextFieldTrailngToSuperAnchor = searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)

        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchTextField.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            searchTextField.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -4),
            searchTextField.heightAnchor.constraint(equalToConstant: 48),
            searchTextFieldTrailngToScanButtonAnchor,
            
            scanButton.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -12),
            scanButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            scanButton.heightAnchor.constraint(equalToConstant: 48),
            scanButton.widthAnchor.constraint(equalToConstant: 48),

            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            favoriteButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: 48),
            favoriteButton.widthAnchor.constraint(equalToConstant: 48),
        ])
    }
    private func setupTargets() {
        searchTextField.addTarget(self, action: #selector(handleSearch), for: .touchDown)
        scanButton.addTarget(self, action: #selector(handleScan), for: .primaryActionTriggered)
        favoriteButton.addTarget(self, action: #selector(handleFavorite), for: .primaryActionTriggered)
    }
    
    @objc func handleScan() {
        scanClosure?()
    }
    
    @objc func handleFavorite() {
        favoriteClosure?()
    }
        
    @objc func handleSearch() {
        searchClosure?()
    }
    
    @objc func toggleSearch() {
        let isIdentity = searchTextFieldTrailngToScanButtonAnchor.isActive
        
        searchTextFieldTrailngToScanButtonAnchor.isActive = !isIdentity
        searchTextFieldTrailngToSuperAnchor.isActive = isIdentity
        
        UIView.animate(withDuration: 0.2) {
            self.scanButton.alpha = isIdentity ? 0 : 1
            self.favoriteButton.alpha = isIdentity ? 0 : 1
            self.layoutIfNeeded()
        }
    }
}
