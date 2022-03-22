//
//  OrderTypeCollectionViewCell.swift
//  24SEVEN
//
//  Created by Islom on 13/02/21.
//

import UIKit


class OrderTypeCollectionViewCell : UICollectionViewCell {
    
    let orderTypeLabel = UILabel.makeLabel(string: "in_wait".localized(using: "Localizable"), size: .l, weight: .bold, alignment: .center)
    
    let orderTypeColors : [UIColor?] = [
       
    ]
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        backgroundColor = .clear
        
        layer.masksToBounds = true
        layer.cornerRadius = 15.0
        
        orderTypeLabel.textColor = UIColor.mainTextColor
        orderTypeLabel.layer.cornerRadius = 15.0
    }
    
    private func layout() {
        contentView.addSubview(orderTypeLabel)
        
        NSLayoutConstraint.activate([
            orderTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            orderTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            orderTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            orderTypeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    
    func setSelected(index: Int, color: UIColor?) {
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = color
            self.orderTypeLabel.textColor = .white
        }
    }
    func setDeselected(index: Int) {
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = .clear
            self.orderTypeLabel.textColor = UIColor.mainTextColor
        }
    }
}
