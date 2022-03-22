//
//  OptionsView.swift
//  24SEVEN
//
//  Created by Islom on 17/02/21.
//

import UIKit

class PaymentOptionsTableViewCell : UITableViewCell {
    
    let titlePaymentType = UILabel.makeLabel(size: .l, weight: .regular, alignment: .center)
    
    let checkmarkButton = UIButton.makeButton(title: "set_as_default".localized(using: "Localizable"), size: .l, weight: .regular, imageName: "Check")
    
    let placeholderView = IBView()
    
    var option: PaymentOptions? {
        didSet {
            guard let option = option else { return }
            switch option {
            case .transfer:
                titlePaymentType.text = "Пиричисление"
                checkmarkButton.setImage(UIImage(named: Constants.chechmarkOff), for: .normal)
            case .cash:
                titlePaymentType.text = "cash".localized(using: "Localizable")
                checkmarkButton.setImage(UIImage(named: Constants.chechmarkOff), for: .normal)
            }
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
        
        placeholderView.layer.cornerRadius = 8.0
        placeholderView.backgroundColor = UIColor.mainSubviewColor
        
        checkmarkButton.isEnabled = false
        
        checkmarkButton.titleLabel?.numberOfLines = 0
        checkmarkButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        checkmarkButton.tintColor = UIColor.mainTextColor
    }
    
    private func layout() {
        contentView.addSubview(placeholderView)
        
        placeholderView.addSubview(titlePaymentType)
        placeholderView.addSubview(checkmarkButton)
        
        NSLayoutConstraint.activate([
            placeholderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            placeholderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            placeholderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            placeholderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
            
            titlePaymentType.leadingAnchor.constraint(equalTo: placeholderView.leadingAnchor, constant: 20),
            titlePaymentType.trailingAnchor.constraint(equalTo: placeholderView.trailingAnchor, constant: -20),
            titlePaymentType.topAnchor.constraint(equalTo: placeholderView.topAnchor, constant: 18),
        
            checkmarkButton.leadingAnchor.constraint(equalTo: placeholderView.leadingAnchor, constant: 20),
            checkmarkButton.trailingAnchor.constraint(equalTo: placeholderView.trailingAnchor, constant: -20),
            checkmarkButton.topAnchor.constraint(equalTo: titlePaymentType.bottomAnchor, constant: 24),
            checkmarkButton.bottomAnchor.constraint(equalTo: placeholderView.bottomAnchor, constant: -16),
        ])
    }
}
