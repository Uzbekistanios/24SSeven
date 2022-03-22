//
//  ItemOrderView.swift
//  24SEVEN
//
//  Created by Islom on 15/02/21.
//

import UIKit

class ItemOrderView : IBView {
   
    let itemImageView = UIImageView.makeImageView(imageName: "Banana")
    
    let titleLabel = UILabel.makeLabel(string: "Банан мини", size: .l, weight: .bold, alignment: .left)
    
    let quantityLabel = UILabel.makeLabel(string: "Количество: 0кг", size: .m, weight: .regular, alignment: .left)
    
    let priceLabel = UILabel.makeLabel(string: "0 сум", size: .m, weight: .regular, alignment: .left)
    
    override init() {
        super.init()
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        backgroundColor = UIColor.mainSubviewColor
        layer.cornerRadius = 8.0
        
        quantityLabel.textColor = .systemGray
        priceLabel.textColor = UIColor.defaultOrange
        
        titleLabel.numberOfLines = 1
        quantityLabel.numberOfLines = 1
        priceLabel.numberOfLines = 1
        
        itemImageView.contentMode = .scaleAspectFit
    }
    
    private func layout() {
        addSubview(itemImageView)
        addSubview(titleLabel)
        addSubview(quantityLabel)
        addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemImageView.topAnchor.constraint(equalTo: topAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 110),
            itemImageView.heightAnchor.constraint(equalToConstant: 100),
            itemImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
            titleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            quantityLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            quantityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            quantityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 1),
            priceLabel.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 14),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
