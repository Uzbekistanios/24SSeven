//
//  OrderDetailsView.swift
//  24SEVEN
//
//  Created by Islom on 15/02/21.
//

import UIKit

class OrderDetailsView: GenericView {
    
    let tableView = IBTableView(cellClass: OrderDetailTableViewCell.self, reuseId: OrderDetailTableViewCell.reuseId)
    
    let targetView = TargetButtonView(title: "cancel_order".localized(using: "Localizable").uppercased())
    
    var buttonHeight: NSLayoutConstraint!
    
    var type: OrderTypes? {
        didSet {
            guard let type = type else { return }
            
            buttonHeight = targetView.heightAnchor.constraint(equalToConstant: 48)
            
            switch type {
            case .active:
                targetView.isHidden = true
                buttonHeight.constant = 0
                targetView.targetButton.removeConstraint(targetView.targetButton.constraints[0]) //remove height constraint for uibutton
            case .delivered:
                targetView.targetButton.setTitle("ПОВТОРНЫЙ ЗАКАЗ", for: .normal)
            case .processing:
                targetView.targetButton.backgroundColor = UIColor(hex: "#DB3022FF") //red
                targetView.targetButton.setTitle("cancel_order".localized(using: "Localizable").uppercased(), for: .normal)
            }
            
            buttonHeight.isActive = true
        }
    }
    
    override init() {
        super.init()
        
        setupTableView()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupTableView() {
        tableView.register(OrderInfoTableViewCell.self, forCellReuseIdentifier: OrderInfoTableViewCell.reuseId)
        
    }
    
    private func style() {
        navBarView.title = "my_orders".localized(using: "Localizable")
    }
    
    private func layout() {
        contentView.addSubview(tableView)
        contentView.addSubview(targetView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        
            targetView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            targetView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            targetView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }
}

