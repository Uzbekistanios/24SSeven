//
//  LogoView.swift
//  24SEVEN
//
//  Created by Islom on 20/02/21.
//

import UIKit

class LogoView : IBView {
    
    let logoImageView = UIImageView.makeImageView(imageName: Constants.largeLogo)
    
    let titleLabel = UILabel.makeLabel(string: """
                    Для продолжения покупки
                    пожалуйста авторизуйтесь
                    через номер телефона
                    """, size: .xl, weight: .bold, alignment: .center)
    
    override init() {
        super.init()
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func layout() {
        addSubview(logoImageView)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 47),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 32),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
