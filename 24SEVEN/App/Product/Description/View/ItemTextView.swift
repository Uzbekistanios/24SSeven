//
//  ItemTextView.swift
//  24SEVEN
//
//  Created by Islom on 11/02/21.
//

import UIKit

class ItemTextView : IBView {
    
    let titleLabel = UILabel.makeLabel(string: "", size: .l, weight: .bold, alignment: .center)
    
    let descriptionLabel = UILabel.makeLabel(string: "", size: .m, weight: .regular, alignment: .left)
    
    let oldPriceLabel = UILabel.makeLabel(string: "8 990 сум", size: .l, weight: .regular, alignment: .left)
    
    override init() {
        super.init()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        titleLabel.textColor = UIColor.mainTextColor
        
        descriptionLabel.textColor = UIColor.mainTextColor
        
        oldPriceLabel.textColor = UIColor.defaultOrange
    }
    
    private func layout() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(oldPriceLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo:  topAnchor, constant: 14),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            oldPriceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            oldPriceLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            oldPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
