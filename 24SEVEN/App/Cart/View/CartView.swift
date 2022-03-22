//
//  CartView.swift
//  24SEVEN
//
//  Created by Islom on 12/02/21.
//

import UIKit


class CartView : GenericView {
    
    let tableView = IBTableView(cellClass: CartItemTableViewCell.self, reuseId: CartItemTableViewCell.reuseId)
    
    let totalLabel = UILabel.makeLabel(string: "total".localized(using: "Localizable"), size: .l, weight: .medium, alignment: .center)
    
    let priceLabel = UILabel.makeLabel(string: "0 сум", size: .l, weight: .bold, alignment: .right)
    
    let checkoutButton = TargetButtonView(title: "check_out".localized(using: "Localizable").uppercased())
    
    override init() {
        super.init()
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func style() {
        priceLabel.textColor = .systemGray
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func layout() {
        contentView.addSubview(tableView)
        contentView.addSubview(totalLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(checkoutButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            totalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            totalLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            
            priceLabel.centerYAnchor.constraint(equalTo: totalLabel.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            checkoutButton.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 24),
            checkoutButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            checkoutButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            checkoutButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -19)
        ])
    }
}
