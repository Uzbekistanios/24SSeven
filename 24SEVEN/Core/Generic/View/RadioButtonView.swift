//
//  RadioButtonView.swift
//  24SEVEN
//
//  Created by Islom on 19/02/21.
//

import UIKit

class RadioButtonView : IBView {
    
    private var outerSize: CGFloat
    
    private var innerSize: CGFloat
    
    let innerEllipse = IBView()
    
    let outerEllipse = IBView()
    
    init(outer: CGFloat, inner: CGFloat) {
        outerSize = outer
        innerSize = inner
        
        super.init()
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        outerEllipse.backgroundColor = .clear
        outerEllipse.layer.borderWidth = 1
        outerEllipse.layer.cornerRadius = outerSize / 2.0
        outerEllipse.layer.borderColor = UIColor.mainTextColor?.cgColor
        
        innerEllipse.backgroundColor = UIColor.mainTextColor
        innerEllipse.layer.cornerRadius = innerSize / 2.0
    }
    
    private func layout() {
        addSubview(outerEllipse)
        addSubview(innerEllipse)
        
        NSLayoutConstraint.activate([
            outerEllipse.leadingAnchor.constraint(equalTo: leadingAnchor),
            outerEllipse.trailingAnchor.constraint(equalTo: trailingAnchor),
            outerEllipse.topAnchor.constraint(equalTo: topAnchor),
            outerEllipse.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            outerEllipse.heightAnchor.constraint(equalToConstant: outerSize),
            outerEllipse.widthAnchor.constraint(equalToConstant: outerSize),
            
            innerEllipse.centerYAnchor.constraint(equalTo: outerEllipse.centerYAnchor),
            innerEllipse.centerXAnchor.constraint(equalTo: outerEllipse.centerXAnchor),
            
            innerEllipse.heightAnchor.constraint(equalToConstant: innerSize),
            innerEllipse.widthAnchor.constraint(equalToConstant: innerSize),
        ])
    }
}
