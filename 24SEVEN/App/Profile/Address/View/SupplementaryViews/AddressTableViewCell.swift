//
//  AddressTableViewCell.swift
//  24SEVEN
//
//  Created by Islom on 17/02/21.
//

import UIKit

class AddressTableViewCell : UITableViewCell {
    
    let addressDescriptionView = AddressDescriptionView()
    
    var editClosure: ((AddressTableViewCell) -> Void)?
    
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
        
        addressDescriptionView.layer.cornerRadius = 8.0
        addressDescriptionView.backgroundColor = UIColor.mainSubviewColor
        addressDescriptionView.editButton.isUserInteractionEnabled = false
    }
    
    private func layout() {
        contentView.addSubview(addressDescriptionView)

        NSLayoutConstraint.activate([
            addressDescriptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            addressDescriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            addressDescriptionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            addressDescriptionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
    
    private func setupTargets() {
        addressDescriptionView.editButton.addTarget(self, action: #selector(handleEdit), for: .primaryActionTriggered)
    }
    
    @objc func handleEdit() {
        editClosure?(self)
    }
}
