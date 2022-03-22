//
//  QuantityView.swift
//  24SEVEN
//
//  Created by Islom on 11/02/21.
//

import UIKit

class QuantityView : IBView {
    
    let actualPriceLabel = UILabel.makeLabel(string: "10 900 сум", size: .xl, weight: .bold, alignment: .left)
    
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
        actualPriceLabel.textColor = UIColor.mainTextColor
    }
    
    private func layout() {
        addSubview(actualPriceLabel)
        addSubview(selectorView)
        
        NSLayoutConstraint.activate([
            actualPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            actualPriceLabel.centerYAnchor.constraint(equalTo: selectorView.centerYAnchor),
            actualPriceLabel.trailingAnchor.constraint(equalTo: selectorView.leadingAnchor, constant: -12),
            
            selectorView.topAnchor.constraint(equalTo: topAnchor),
            selectorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            selectorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
