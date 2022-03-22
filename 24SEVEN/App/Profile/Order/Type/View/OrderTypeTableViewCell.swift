//
//  OrderTypeTableViewCell.swift
//  24SEVEN
//
//  Created by Islom on 13/02/21.
//

import UIKit

class OrderTypeTableViewCell : UITableViewCell {
    
    let orderDescription = OrderDescriptionView()
    
    var type: OrderTypes! {
        didSet {
            orderDescription.statusLabel.text = type.title
            orderDescription.statusLabel.textColor = type.color
        }
    }
    
    var cellOrderModel : OrderItem? {
        didSet {
            guard let model = cellOrderModel else {return}
            let overallPrice = (model.priceProducts ?? 0) + (model.priceDelivery ?? 0)
         
            orderDescription.orderNumberLabel.text = "Заказ №".localized(using: "Localizable") + "\(model.id?.description ?? "")"
            orderDescription.dateLabel.text = model.createdAt
            orderDescription.quantityNumLabel.text = model.productsCount?.description
            orderDescription.totalPriceLabel.text = overallPrice.description
            orderDescription.statusLabel.text = model.status
        }
    }
    
    var inspectClosure: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.style()
        self.layout()
        self.setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func layout() {
        contentView.addSubview(orderDescription)
        
        NSLayoutConstraint.activate([
            orderDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            orderDescription.topAnchor.constraint(equalTo: contentView.topAnchor),
            orderDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            orderDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
    
    private func setupTargets() {
        orderDescription.inspectButton.addTarget(self, action: #selector(handleInspect), for: .primaryActionTriggered)
    }
    
    @objc func handleInspect() {
        inspectClosure?()
    }
}
