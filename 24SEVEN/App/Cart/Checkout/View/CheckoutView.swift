//
//  CheckoutView.swift
//  24SEVEN
//
//  Created by Islom on 12/02/21.
//

import UIKit

class CheckoutView: GenericScrollView {
    
    let savedView = SavedAddressesView()
    
    let fillView = FillAddressView()
    
    let paymentView = PaymentView()
    
    let totalPriceView = TotalPriceView()
    
    let targetButton = TargetButtonView(title: "confirm_order".localized(using: "Localizable"))
    
    override init() {
        super.init()
        
        style()
        layout()
        tableViewRadio()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func tableViewRadio() {
        paymentView.tableView.register(PaymentTypeRadioButtonCell.self, forCellReuseIdentifier: PaymentTypeRadioButtonCell.reuseId)
    }
    
    private func style() {
        navBarView.title = "check_out".localized(using: "Localizable")
    }
    
    private func layout() {
        scrollContent.addSubview(savedView)
        scrollContent.addSubview(fillView)
        scrollContent.addSubview(paymentView)
        scrollContent.addSubview(totalPriceView)
        scrollContent.addSubview(targetButton)
        
        NSLayoutConstraint.activate([
            savedView.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            savedView.topAnchor.constraint(equalTo: scrollContent.topAnchor),
            savedView.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            
            fillView.topAnchor.constraint(equalTo: savedView.bottomAnchor),
            fillView.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            fillView.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            
            paymentView.topAnchor.constraint(equalTo: fillView.bottomAnchor),
            paymentView.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            paymentView.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            
            totalPriceView.topAnchor.constraint(equalTo: paymentView.bottomAnchor),
            totalPriceView.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            totalPriceView.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            
            targetButton.topAnchor.constraint(equalTo: totalPriceView.bottomAnchor, constant: 24),
            targetButton.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor, constant: 16),
            targetButton.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor, constant: -16),
            targetButton.bottomAnchor.constraint(lessThanOrEqualTo: scrollContent.bottomAnchor, constant: -27)
        ])
    }
}
