//
//  CashView.swift
//  24SEVEN
//
//  Created by Islom on 19/02/21.
//

import UIKit

class CashView : IBView {
    
    let cashImageView = UIImageView.makeImageView(imageName: Constants.cash)
    
    let cashLabel = UILabel.makeLabel(string: "Наличные", size: .xxl, weight: .bold, alignment: .center)
    
    override init() {
        super.init()
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        backgroundColor = .clear
    }
    
    private func layout() {
        addSubview(cashImageView)
        addSubview(cashLabel)
        
        NSLayoutConstraint.activate([
            cashImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cashImageView.topAnchor.constraint(equalTo: topAnchor),
            cashImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cashLabel.centerYAnchor.constraint(equalTo: cashImageView.centerYAnchor),
            cashLabel.leadingAnchor.constraint(equalTo: cashImageView.trailingAnchor, constant: 16),
            cashLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
