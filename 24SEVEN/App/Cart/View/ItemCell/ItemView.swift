//
//  ItemView.swift
//  24SEVEN
//
//  Created by Islom on 12/02/21.
//

import UIKit

class ItemView : IBView {
    
    let itemImageView = UIImageView.makeImageView(imageName: "Banana")
    
    let titleLabel = UILabel.makeLabel(string: "Банан мини", size: .l, weight: .bold, alignment: .left)
    
    let removeItem = UIButton.makeButton(imageName: Constants.removeButton, addShadow: true)
    
    let priceLabel = UILabel.makeLabel(string: "39 900 сум за кг", size: .m, weight: .regular, alignment: .left)
    
    let selectorView = SelectorView()

    override init() {
        super.init()
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        layer.masksToBounds = true
        layer.cornerRadius = 8.0
        backgroundColor = UIColor.mainSubviewColor

        titleLabel.textColor = UIColor.mainTextColor
        titleLabel.numberOfLines = 2
        
        removeItem.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        removeItem.tintColor = .defaultOrange
        
        priceLabel.textColor = UIColor.defaultOrange
        selectorView.backgroundColor = .clear
        itemImageView.contentMode = .scaleAspectFit
    }
    
    private func layout() {
        addSubview(itemImageView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(selectorView)
        addSubview(removeItem)
        
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: topAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 100),
            itemImageView.heightAnchor.constraint(equalToConstant: 112),
            
            removeItem.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            removeItem.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            removeItem.widthAnchor.constraint(equalToConstant: 32),
            removeItem.heightAnchor.constraint(equalToConstant: 32),
            
            titleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: removeItem.leadingAnchor, constant: -4),
            
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            priceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            selectorView.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
            selectorView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            selectorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
}
