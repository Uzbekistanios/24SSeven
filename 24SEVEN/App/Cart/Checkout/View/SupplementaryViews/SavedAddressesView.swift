//
//  SavedAddressesView.swift
//  24SEVEN
//
//  Created by Islom on 12/02/21.
//

import UIKit

class SavedAddressesView : IBView {
    
    let addressLabel = UILabel.makeLabel(string: "delivery_address".localized(using: "Localizable"), size: .l, weight: .bold, alignment: .left)
    
    let placeholderView = IBView()
    
    let savedLabel = UILabel.makeLabel(string: "saved_addresses".localized(using: "Localizable"), size: .l, weight: .regular, alignment: .center)
    
    let chevronButton = UIButton.makeButton(imageName: Constants.chevronDown)
    
    var viewTouchListener: (() -> Void)?
    
    override init() {
        super.init()
        
        style()
        layout()
        textFieldAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        addressLabel.textColor = UIColor.mainTextColor
        
        placeholderView.backgroundColor = UIColor.mainSubviewColor
        placeholderView.layer.cornerRadius = 8.0
        
        savedLabel.textColor = UIColor.mainTextColor
        
        chevronButton.tintColor = UIColor.mainTextColor
        chevronButton.isUserInteractionEnabled = false
    }
    
    private func textFieldAction() {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.placeholderView.addGestureRecognizer(gesture)
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        viewTouchListener?()
    }
    
    private func layout() {
        addSubview(addressLabel)
        addSubview(placeholderView)
        addSubview(savedLabel)
        addSubview(chevronButton)
        
        NSLayoutConstraint.activate([
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            addressLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            placeholderView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 12),
            placeholderView.leadingAnchor.constraint(equalTo: addressLabel.leadingAnchor),
            placeholderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            placeholderView.heightAnchor.constraint(equalToConstant: 48),
            placeholderView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            savedLabel.leadingAnchor.constraint(equalTo: placeholderView.leadingAnchor, constant: 20),
            savedLabel.topAnchor.constraint(equalTo: placeholderView.topAnchor, constant: 12),
            savedLabel.bottomAnchor.constraint(equalTo: placeholderView.bottomAnchor, constant: -12),
            
            chevronButton.trailingAnchor.constraint(equalTo: placeholderView.trailingAnchor, constant: -12),
            chevronButton.topAnchor.constraint(equalTo: placeholderView.topAnchor, constant: 12),
            chevronButton.heightAnchor.constraint(equalToConstant: 24),
            chevronButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
}

