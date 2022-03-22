//
//  PaymentOptionsView.swift
//  24SEVEN
//
//  Created by Islom on 17/02/21.
//

import UIKit

class PaymentOptionsView : GenericView {
    
    let tableView = IBTableView(cellClass: PaymentOptionsTableViewCell.self, reuseId: PaymentOptionsTableViewCell.reuseId)
    
    let targetView = TargetButtonView(title: "save".localized(using: "Localizable"))
    
    override init() {
        super.init()
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        navBarView.title = "Способы оплаты"
    }
    
    private func layout() {
        contentView.addSubview(tableView)
        contentView.addSubview(targetView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            tableView.bottomAnchor.constraint(equalTo: targetView.topAnchor, constant: -20),
            
            targetView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            targetView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            targetView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
        ])
    }
}
