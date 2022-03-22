//
//  TypeView.swift
//  24SEVEN
//
//  Created by Islom on 13/02/21.
//

import UIKit

class TypeView: UIView {
    
    let tableView = IBTableView(cellClass: OrderTypeTableViewCell.self, reuseId: OrderTypeTableViewCell.reuseId)
    
    let noOrderItem = UIImageView.makeImageView(imageName: "noOrder")
    
    init() {
        super.init(frame: .zero)
        layout()
        style()
    }
    
    private func style() {
        noOrderItem.isHidden = true
        noOrderItem.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func layout() {
        addSubview(tableView)
        addSubview(noOrderItem)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            noOrderItem.leadingAnchor.constraint(equalTo: leadingAnchor),
            noOrderItem.trailingAnchor.constraint(equalTo: trailingAnchor),
            noOrderItem.centerYAnchor.constraint(equalTo: centerYAnchor),
            noOrderItem.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.65),
        ])
    }
    
}
