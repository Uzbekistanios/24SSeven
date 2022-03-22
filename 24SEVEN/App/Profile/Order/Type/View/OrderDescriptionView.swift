//
//  OrderDescriptionView.swift
//  24SEVEN
//
//  Created by Islom on 15/02/21.
//

import UIKit

class OrderDescriptionView : IBView {
   
    let orderNumberLabel = UILabel.makeLabel(string: "Заказ №1147034", size: .l, weight: .bold, alignment: .center)
    
    let dateLabel = UILabel.makeLabel(string: "", size: .m, weight: .regular, alignment: .center)
    
    let quantityLabel = UILabel.makeLabel(string: "order_item_count".localized(using: "Localizable"), size: .m, weight: .regular, alignment: .center)
    
    let quantityNumLabel = UILabel.makeLabel(string: "", size: .m, weight: .bold, alignment: .center)
    
    let totalLabel = UILabel.makeLabel(string: "total_price".localized(using: "Localizable"), size: .m, weight: .regular, alignment: .center)
    
    let totalPriceLabel = UILabel.makeLabel(string: "", size: .m, weight: .regular, alignment: .center)
    
    let inspectButton = UIButton.makeButton(title: "more".localized(using: "Localizable"), size: .l, weight: .bold, insets: true, cornerRadius: 18.0)
    
    let statusLabel = UILabel.makeLabel(string: "in_wait".localized(using: "Localizable"), size: .m, weight: .regular, alignment: .center)
    
    override init() {
        super.init()
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        backgroundColor = UIColor.mainSubviewColor
        layer.cornerRadius = 8.0
        
        quantityLabel.textColor = .systemGray
        
        totalLabel.textColor = .systemGray
        
        dateLabel.textColor = .systemGray
        
        inspectButton.layer.borderWidth = 1.0
        inspectButton.layer.borderColor = UIColor.mainTextColor?.cgColor
        inspectButton.setTitleColor(UIColor.mainTextColor, for: .normal)
    }
    
    private func layout() {
        addSubview(orderNumberLabel)
        addSubview(dateLabel)
        addSubview(quantityLabel)
        addSubview(quantityNumLabel)
        addSubview(totalLabel)
        addSubview(totalPriceLabel)
        addSubview(inspectButton)
        addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            orderNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            orderNumberLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            
            quantityLabel.leadingAnchor.constraint(equalTo: orderNumberLabel.leadingAnchor),
            quantityLabel.topAnchor.constraint(equalTo: orderNumberLabel.bottomAnchor, constant: 12),
            
            quantityNumLabel.centerYAnchor.constraint(equalTo: quantityLabel.centerYAnchor),
            quantityNumLabel.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: 12),
            
            totalLabel.leadingAnchor.constraint(equalTo: quantityLabel.leadingAnchor),
            totalLabel.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 12),
            
            totalPriceLabel.centerYAnchor.constraint(equalTo: totalLabel.centerYAnchor),
            totalPriceLabel.leadingAnchor.constraint(equalTo: totalLabel.trailingAnchor, constant: 12),
            
            inspectButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17),
            inspectButton.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 20),
            inspectButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            inspectButton.widthAnchor.constraint(equalToConstant: 120),
            
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusLabel.centerYAnchor.constraint(equalTo: inspectButton.centerYAnchor)
        ])
    }
}
