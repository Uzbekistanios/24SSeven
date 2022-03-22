//
//  SuccessView.swift
//  24SEVEN
//
//  Created by Islom on 12/02/21.
//

import UIKit

class SuccessView : GenericScrollView {
    
    let image = UIImageView.makeImageView(imageName: Constants.success)
    
    let titleLabel = UILabel.makeLabel(string: "Успех", size: .ultraPageTitle, weight: .bold, alignment: .center)
    
    let descriptionLabel = UILabel.makeLabel(string: """
        Ваш заказ скоро будет доставлен.
        Спасибо, что выбрали наше приложение!
        """, size: .m, weight: .regular, alignment: .center)
    
    let targetButton = TargetButtonView(title: "ПРОДОЛЖИТЬ ПОКУПКИ")
    
    override init() {
        super.init()
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        navBarView.isHidden = true
        
        titleLabel.textColor = UIColor.mainTextColor
        
        descriptionLabel.textColor = UIColor.mainTextColor
    }
    
    private func layout() {
        
//        addSubview(image)
//        addSubview(titleLabel)
//        addSubview(descriptionLabel)
//        addSubview(targetButton)
//
//        NSLayoutConstraint.activate([
//            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 102),
//            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 70),
//
//            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 132),
//            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 46),
//
//            descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
//
//            targetButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -44),
//            targetButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            targetButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16)
//        ])
        
        scrollContent.addSubview(image)
        scrollContent.addSubview(titleLabel)
        scrollContent.addSubview(descriptionLabel)
        scrollContent.addSubview(targetButton)
        
        NSLayoutConstraint.activate([

            image.centerXAnchor.constraint(equalTo: scrollContent.centerXAnchor),
            image.topAnchor.constraint(equalTo: scrollContent.topAnchor, constant: 50),

            titleLabel.centerXAnchor.constraint(equalTo: image.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 30),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),

            targetButton.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor, constant: 16),
            targetButton.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor, constant: -16),
            targetButton.bottomAnchor.constraint(lessThanOrEqualTo: scrollContent.bottomAnchor, constant: -44),
        ])
    }
}

