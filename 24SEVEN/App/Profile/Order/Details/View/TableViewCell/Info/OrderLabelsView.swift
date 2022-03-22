//
//  OrderLabelsView.swift
//  24SEVEN
//
//  Created by Islom on 15/02/21.
//

import UIKit

class OrderLabelsView : IBView {
    
    let defaultDateLabel = UILabel.makeLabel(string: "order_time".localized(using: "Localizable"), size: .m, weight: .regular, alignment: .left)
    
    let dateLabel = UILabel.makeLabel(string: "20:08 05-12-2020", size: .m, weight: .regular, alignment: .left)
    
    let defaultQuantityLabel = UILabel.makeLabel(string: "order_item_count".localized(using: "Localizable"), size: .m, weight: .regular, alignment: .left)
    
    let quantityLabel = UILabel.makeLabel(string: "4 товара", size: .m, weight: .regular, alignment: .left)
    
    let defaultAddressLabel = UILabel.makeLabel(string: "order_address".localized(using: "Localizable"), size: .m, weight: .regular, alignment: .left)
    
    let addressLabel = UILabel.makeLabel(string: "2118 Thornridge Cir. Syracuse,Connecticut 35624", size: .m, weight: .regular, alignment: .left)
    
    let defaultPaymentLabel = UILabel.makeLabel(string: "payment_Method".localized(using: "Localizable"), size: .m, weight: .regular, alignment: .left)
    
    let paymentLabel = UILabel.makeLabel(string: "Payme", size: .m, weight: .regular, alignment: .left)
    
    let defaultTotalLabel = UILabel.makeLabel(string: "order_total".localized(using: "Localizable"), size: .m, weight: .regular, alignment: .left)
    
    let totalLabel = UILabel.makeLabel(string: "156 500 сум", size: .m, weight: .regular, alignment: .left)
    
    override init() {
        super.init()
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        defaultDateLabel.textColor = .systemGray
        
        defaultQuantityLabel.textColor = .systemGray
        
        defaultAddressLabel.textColor = .systemGray
        
        defaultPaymentLabel.textColor = .systemGray
        
        defaultTotalLabel.textColor = .systemGray
    }
    
    private func layout() {
        addSubview(defaultDateLabel)
        addSubview(dateLabel)
        addSubview(defaultQuantityLabel)
        addSubview(quantityLabel)
        addSubview(defaultAddressLabel)
        addSubview(addressLabel)
        addSubview(defaultPaymentLabel)
        addSubview(paymentLabel)
        addSubview(defaultTotalLabel)
        addSubview(totalLabel)
        
        let totalLabelBottom = totalLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        totalLabelBottom.priority = UILayoutPriority(749)
        
        NSLayoutConstraint.activate([
            defaultDateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            defaultDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            defaultDateLabel.widthAnchor.constraint(equalToConstant: 110),
            
            dateLabel.leadingAnchor.constraint(equalTo: defaultDateLabel.trailingAnchor, constant: 8),
            dateLabel.centerYAnchor.constraint(equalTo: defaultDateLabel.centerYAnchor),
            
            defaultQuantityLabel.leadingAnchor.constraint(equalTo: defaultDateLabel.leadingAnchor),
            defaultQuantityLabel.topAnchor.constraint(equalTo: defaultDateLabel.bottomAnchor, constant: 15),
            
            quantityLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            quantityLabel.centerYAnchor.constraint(equalTo: defaultQuantityLabel.centerYAnchor),
            
            defaultAddressLabel.leadingAnchor.constraint(equalTo: defaultDateLabel.leadingAnchor),
            defaultAddressLabel.topAnchor.constraint(equalTo: defaultQuantityLabel.bottomAnchor, constant: 15),
            
            addressLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            addressLabel.centerYAnchor.constraint(equalTo: defaultAddressLabel.centerYAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            defaultPaymentLabel.leadingAnchor.constraint(equalTo: defaultDateLabel.leadingAnchor),
            defaultPaymentLabel.topAnchor.constraint(equalTo: defaultAddressLabel.bottomAnchor, constant: 15),
            
            paymentLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            paymentLabel.centerYAnchor.constraint(equalTo: defaultPaymentLabel.centerYAnchor),
            
            defaultTotalLabel.leadingAnchor.constraint(equalTo: defaultDateLabel.leadingAnchor),
            defaultTotalLabel.topAnchor.constraint(equalTo: defaultPaymentLabel.bottomAnchor, constant: 15),
            
            totalLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            totalLabel.centerYAnchor.constraint(equalTo: defaultTotalLabel.centerYAnchor),
            
            totalLabelBottom
        ])
    }
}
