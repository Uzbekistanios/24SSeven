//
//  TotalPriceView.swift
//  24SEVEN
//
//  Created by Islom on 12/02/21.
//

import UIKit

class TotalPriceView : IBView {
    
    let initialPrice = PriceView(title: "order_price".localized(using: "Localizable"), price: "0 сум")
    
    let deliveryPrice = PriceView(title: "delivery_price".localized(using: "Localizable"), price: "0 сум")
    
    let totalPrice = PriceView(title: "total".localized(using: "Localizable"), price: "0 сум", bold: true)
    
    let stackView = IBStackView(axis: .vertical, distribution: .fill, alignment: .fill)
        
    override init() {
        super.init()
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        stackView.spacing = 11
        
    }
    
    private func layout() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(initialPrice)
        stackView.addArrangedSubview(deliveryPrice)
        stackView.addArrangedSubview(totalPrice)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 44),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
