//
//  ProfileSettingsTableViewCell.swift
//  24SEVEN
//
//  Created by Islom on 13/02/21.
//

import UIKit

class ProfileSettingsTableViewCell : UITableViewCell {
    
    let titleLabel = UILabel.makeLabel(string: "my_orders".localized(using: "Localizable"), size: .l, weight: .bold, alignment: .center)
    
    let descriptionLabel = UILabel.makeLabel(string: "12 заказов", size: .m, weight: .regular, alignment: .center)
    
    let chevronImageView = UIImageView.makeImageView(imageName: Constants.chevronRight)
    
    let spacerView = IBView()
    
    var type: ProfileSection? {
        didSet {
            guard let type = type else { return }
            titleLabel.text = type.title
            descriptionLabel.text = type.description
        }
    }
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
        
        titleLabel.textColor = UIColor.mainTextColor
        
        descriptionLabel.textColor = .systemGray
        
        spacerView.backgroundColor = .systemGray
    }
    
    private func layout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(chevronImageView)
        contentView.addSubview(spacerView)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 1),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            
            chevronImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            chevronImageView.bottomAnchor.constraint(equalTo: spacerView.topAnchor, constant: -14),
            chevronImageView.heightAnchor.constraint(equalToConstant: 24),
            chevronImageView.widthAnchor.constraint(equalToConstant: 24),
            
            spacerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            spacerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            spacerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            spacerView.heightAnchor.constraint(equalToConstant: 0.2)
        ])
        
    }
}
