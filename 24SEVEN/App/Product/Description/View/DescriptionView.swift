//
//  DescriptionView.swift
//  24SEVEN
//
//  Created by Islom on 11/02/21.
//

import UIKit

class DescriptionView : IBView {
    
    var viewModel: CategoryProductItem? {
        didSet {
            itemText.titleLabel.text = viewModel?.name
          
            if viewModel?.priceDiscount != nil {
                itemText.oldPriceLabel.attributedText = ("\(viewModel?.discountedPrice?.description ?? "")" + "money_format_sum".localized(using: "Localizable")).strikeThrough()
            } else {
                itemText.oldPriceLabel.isHidden = true
            }
            
            if viewModel?.description?.htmlToString != "null" {
                itemText.descriptionLabel.text = viewModel?.description?.htmlToString
            } else {
                itemText.descriptionLabel.isHidden = true
            }
        
            quantity.actualPriceLabel.text = "\(viewModel?.actualPrice?.description ?? "")" + "money_format_sum".localized(using: "Localizable")
            quantity.selectorView.quantityLabel.text = "\(viewModel?.unit?.count ?? 1) \(viewModel?.unit?.name ?? "")"
        }
    }
   
    let itemText = ItemTextView()
    
    let quantity = QuantityView()
    
    let addToCart = UIButton.makeButton(title: "В КОРЗИНУ", size: .l, weight: .regular, imageName: Constants.addToCart, insets: true, cornerRadius: 20.0)
    
    var cartHandler : (() -> Void)?
    
    override init() {
        super.init()
        
        style()
        layout()
        localize()
        cartTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func cartTarget() {
        addToCart.addTarget(self, action: #selector(cartAction), for: .primaryActionTriggered)
    }
    
    @objc func cartAction() {
        cartHandler?()
    }
    
    private func localize() {
       
    }
    
    private func style() {
        addToCart.backgroundColor = UIColor.mainButtonBackgrounColor
        addToCart.tintColor = .white
        addToCart.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
    }
    
    private func layout() {
        addSubview(itemText)
        addSubview(quantity)
        addSubview(addToCart)
        
        NSLayoutConstraint.activate([
            itemText.topAnchor.constraint(equalTo: topAnchor),
            itemText.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemText.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            quantity.topAnchor.constraint(equalTo: itemText.bottomAnchor, constant: 20),
            quantity.leadingAnchor.constraint(equalTo: leadingAnchor),
            quantity.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            addToCart.topAnchor.constraint(equalTo: quantity.bottomAnchor, constant: 40),
            addToCart.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            addToCart.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addToCart.heightAnchor.constraint(equalToConstant: 48),
            addToCart.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
