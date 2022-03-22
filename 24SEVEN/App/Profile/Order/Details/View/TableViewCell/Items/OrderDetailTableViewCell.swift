//
//  OrderDetailTableViewCell.swift
//  24SEVEN
//
//  Created by Islom on 15/02/21.
//

import UIKit

class OrderDetailTableViewCell : UITableViewCell {
    
    let item = ItemOrderView()
    
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
        contentView.addSubview(item)
        
        NSLayoutConstraint.activate([
            item.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            item.topAnchor.constraint(equalTo: contentView.topAnchor),
            item.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            item.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        
        ])
    }
}
