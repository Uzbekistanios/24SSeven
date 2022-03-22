//
//  AddressDescriptionView.swift
//  24SEVEN
//
//  Created by Islom on 17/02/21.
//

import UIKit

class AddressDescriptionView : IBView {
    
    let addressLabel = UILabel.makeLabel(string: "Дом", size: .l, weight: .bold, alignment: .center)
    
    let infoLabel = UILabel.makeLabel(string: "2118 Thornridge Cir. Syracuse, Connecticut 35624", size: .m, weight: .regular, alignment: .left)
    
    let editButton = UIButton.makeButton(title: "edit".localized(using: "Localizable"), size: .m, weight: .regular, insets: true)
    
    override init() {
        super.init()
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        editButton.setTitleColor(UIColor.defaultOrange, for: .normal)
    }
    
    private func layout() {
        addSubview(addressLabel)
        addSubview(infoLabel)
        addSubview(editButton)
        
        
        NSLayoutConstraint.activate([
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            addressLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            infoLabel.leadingAnchor.constraint(equalTo: addressLabel.leadingAnchor),
            infoLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 9),
            infoLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
            infoLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            editButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
        ])
       
        
    }
}
