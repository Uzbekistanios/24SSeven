//
//  OrderInfoTableViewCell.swift
//  24SEVEN
//
//  Created by Islom on 15/02/21.
//

import UIKit


class OrderInfoTableViewCell : UITableViewCell {
    
    let infoLabel = UILabel.makeLabel(string: "order_info".localized(using: "Localizable"), size: .l, weight: .bold, alignment: .center)
    
    let orderNumLabel = UILabel.makeLabel(string: "Заказ №1947034", size: .m, weight: .bold, alignment: .center)
    
    let statusLabel = UILabel.makeLabel(string: "in_wait".localized(using: "Localizable"), size: .m, weight: .regular, alignment: .center)
    
    let labelsView = OrderLabelsView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.style()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func layout() {
        contentView.addSubview(infoLabel)
        contentView.addSubview(orderNumLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(labelsView)
        
        
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 1),
            infoLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            orderNumLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            orderNumLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 24),
            
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: orderNumLabel.centerYAnchor, constant: -4),
            
            labelsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            labelsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            labelsView.topAnchor.constraint(equalTo: orderNumLabel.bottomAnchor),
            labelsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
}

