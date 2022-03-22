//
//  ProductDetailsView.swift
//  24SEVEN
//
//  Created by Islom on 03/02/21.
//

import UIKit

class ProductDetailsView: IBView {
    
    let itemImageView = UIImageView.makeImageView(imageName: "Apple")
    
    let discountView = DiscountView()
    
    let favoriteButton = UIButton.makeButton(imageName: Constants.notFavorite)
 
    override init() {
        super.init()
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension ProductDetailsView {
    private func style() {
        favoriteButton.tintColor = .systemGray
        favoriteButton.backgroundColor = .clear
        
        itemImageView.backgroundColor = UIColor.mainSubviewColor
        itemImageView.contentMode = .scaleAspectFit
        
        favoriteButton.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    private func layout() {
        addSubview(itemImageView)
        addSubview(discountView)
        addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: topAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemImageView.heightAnchor.constraint(equalToConstant: 156),
            itemImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            
            discountView.leadingAnchor.constraint(equalTo: leadingAnchor),
            discountView.topAnchor.constraint(equalTo: topAnchor),
            discountView.heightAnchor.constraint(equalToConstant: 20),
            discountView.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
}
