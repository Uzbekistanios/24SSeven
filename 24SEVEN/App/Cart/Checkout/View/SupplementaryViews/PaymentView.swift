//
//  PaymentView.swift
//  24SEVEN
//
//  Created by Islom on 12/02/21.
//

import UIKit

class PaymentView : IBView {
    
    let paymentLabel = UILabel.makeLabel(string: "payment_method".localized(using: "Localizable"), size: .l, weight: .bold, alignment: .left)
     
    var tableView: ContentSizedTableView = {
        let tableView = ContentSizedTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.rowHeight = 35
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
            
    override init() {
        super.init()
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
  
    
    private func style() {
        paymentLabel.textColor = UIColor.mainTextColor
    }
    
    private func layout() {
        addSubview(paymentLabel)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            paymentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            paymentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            paymentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: paymentLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
