//
//  PriceView.swift
//  24SEVEN
//
//  Created by Islom on 12/02/21.
//

import UIKit


class PriceView: IBView {
    
    let titleLabel: UILabel
    
    let priceLabel: UILabel
    
    init(title: String, price: String, bold: Bool = false) {
        titleLabel = UILabel.makeLabel(string: title, size: .xl, weight: .regular, alignment: .center)
        priceLabel = UILabel.makeLabel(string: price, size: .l, weight: .regular, alignment: .center)
        super.init()
        
        style(bold)
        layout()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style(_ bold: Bool) {
        if bold {
            priceLabel.font = UIFont.appFont(weight: .bold)
        }
        
        titleLabel.textColor = .systemGray
        
        priceLabel.textColor = UIColor.mainTextColor
    }
    
    private func layout() {
        addSubview(titleLabel)
        addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            priceLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16)
        ])
    }
}
