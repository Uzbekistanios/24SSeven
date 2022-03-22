//
//  CartItemTableViewCell.swift
//  24SEVEN
//
//  Created by Islom on 12/02/21.
//

import UIKit

protocol CartItemTableViewCellProtocol: AnyObject {
    func didChangeItemCount(cell: CartItemTableViewCell, sender: UIButton)
    func removeItem(cell: CartItemTableViewCell)
}

class CartItemTableViewCell : UITableViewCell {
    
    let item = ItemView()
    var cellID: Int?

    internal var delegate: CartItemTableViewCellProtocol?
    internal var productItem: BasketModel?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.style()
        self.layout()
        setupIncreaseDecrease()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func setupIncreaseDecrease() {
        item.selectorView.decrementButton.tag = 1
        item.selectorView.incrementButton.tag = 2
        
        item.removeItem.addTarget(self, action: #selector(removeItemAction), for: .primaryActionTriggered)
        item.selectorView.decrementButton.addTarget(self, action: #selector(handleItemCountChange(sender:)), for: .primaryActionTriggered)
        item.selectorView.incrementButton.addTarget(self, action: #selector(handleItemCountChange(sender:)), for: .primaryActionTriggered)
    }
    
    @objc func handleItemCountChange(sender: UIButton) {
        delegate?.didChangeItemCount(cell: self, sender: sender)
    }
    
    @objc func removeItemAction() {
        delegate?.removeItem(cell: self)
    }
    
    private func layout() {
        contentView.addSubview(item)
        
        NSLayoutConstraint.activate([
            item.topAnchor.constraint(equalTo: contentView.topAnchor),
            item.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            item.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            item.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
        
    }
}
