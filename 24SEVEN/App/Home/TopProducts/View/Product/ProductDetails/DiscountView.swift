//
//  DiscountView.swift
//  24SEVEN
//
//  Created by Islom on 03/02/21.
//

import UIKit

class DiscountView: IBView {
    
    let discountLabel = UILabel.makeLabel(string: "-20%", size: .m, weight: .bold, alignment: .center)
    
    override init() {
        super.init()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        backgroundColor = UIColor.defaultOrange
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        layer.cornerRadius = 10.0
        
        discountLabel.textColor = UIColor.mainSubviewColor
        discountLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func layout() {
        addSubview(discountLabel)
        
        NSLayoutConstraint.activate([
            discountLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            discountLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
