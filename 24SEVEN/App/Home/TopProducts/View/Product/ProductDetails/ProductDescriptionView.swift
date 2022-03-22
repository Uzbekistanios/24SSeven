//
//  ProductDescriptionView.swift
//  24SEVEN
//
//  Created by Islom on 03/02/21.
//

import UIKit

class ProductDescriptionView: IBView {
    
    let stackView = IBStackView(axis: .vertical, distribution: .fill, alignment: .leading)
    
    let commentsButton = UIButton.makeButton(title: "Отзыв (15)", size: .m, weight: .regular, imageName: Constants.comments,imageInsets: true)
    
    let categoryLabel = UILabel.makeLabel(string: "Фрукты", size: .m, weight: .regular, alignment: .left)
    
    let productNameLabel = UILabel.makeLabel(string: "Яблоко Бойка", size: .l, weight: .bold, alignment: .left)
    
    let oldPriceLabel = UILabel.makeLabel(string: "8 990 сум", size: .m, weight: .regular, alignment: .left)
    
    let currentPriceLabel = UILabel.makeLabel(string: "7 490 сум за кг", size: .l, weight: .regular, alignment: .right)
    
    
    
    override init() {
        super.init()
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func style() {
        backgroundColor = UIColor.mainSubviewColor
        
        commentsButton.setTitleColor(.systemGray, for: .normal)
        commentsButton.backgroundColor = .clear
        commentsButton.tintColor = UIColor.defaultOrange
        productNameLabel.numberOfLines = 2
    
        categoryLabel.textColor = .systemGray
        oldPriceLabel.textColor = UIColor.defaultOrange
       
        currentPriceLabel.minimumScaleFactor = 0.6
        currentPriceLabel.numberOfLines = 1
    }
    
    private func layout() {
        addSubview(commentsButton)
        addSubview(stackView)
        addSubview(currentPriceLabel)
        
        stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(productNameLabel)
        stackView.addArrangedSubview(oldPriceLabel)
        
        NSLayoutConstraint.activate([
            commentsButton.topAnchor.constraint(equalTo: topAnchor),
            commentsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 9),
            
            stackView.topAnchor.constraint(equalTo: commentsButton.bottomAnchor, constant: 4),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 9),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: currentPriceLabel.topAnchor, constant: -4),
            
            currentPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -9),
            currentPriceLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            currentPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
        ])
    }
}
