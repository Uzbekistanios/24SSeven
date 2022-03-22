//
//  FilterNavBarView.swift
//  24SEVEN
//
//  Created by Islom on 26/02/21.
//

import UIKit

class FilterNavBarView : IBView {
    
    let backButton = UIButton.makeNavBarButton()
    
    let titleLabel = UILabel.makeLabel(string: "filter".localized(using: "Localizable"), size: .xl, weight: .bold, alignment: .center)
    
    let doneButton = UIButton.makeButton(title: "done".localized(using: "Localizable"), size: .l, weight: .regular)
    
    override init() {
        super.init()
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        doneButton.tintColor = UIColor.defaultOrange
    }
    
    private func layout() {
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(doneButton)
 
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.bottomAnchor.constraint(equalTo: bottomAnchor),
           
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 4),
            
            doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            doneButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
        ])
    }
}

