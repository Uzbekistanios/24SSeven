//
//  FillAddressView.swift
//  24SEVEN
//
//  Created by Islom on 12/02/21.
//

import UIKit

class FillAddressView : IBView {
    
    let fillLabel = UILabel.makeLabel(string: "give_address".localized(using: "Localizable"), size: .l, weight: .black, alignment: .center)
    
    let phoneTextField = FillTextField(placeholder: "phone_number".localized(using: "Localizable"), type: .phone)
    
    let addressTextField = FillTextField(placeholder: "address".localized(using: "Localizable"))
    
    let districtTextField = FillTextField(placeholder: "district".localized(using: "Localizable"))
    
    let cityTextField = FillTextField(placeholder: "city".localized(using: "Localizable"))
    
    let mapButton = UIButton.makeButton(title: "from_map".localized(using: "Localizable"), size: .m, weight: .medium, imageName: Constants.map, insets: true, imageInsets: true)
    
    var mapClosure: (() -> Void)?
    
    override init() {
        super.init()
        
        style()
        layout()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        mapButton.tintColor = .systemRed
        mapButton.setTitleColor(UIColor(hex: "#4168C9FF"), for: .normal)
    }
    
    private func layout() {
        addSubview(fillLabel)
        addSubview(phoneTextField)
        addSubview(addressTextField)
        addSubview(districtTextField)
        addSubview(cityTextField)
        addSubview(mapButton)
        
        
        NSLayoutConstraint.activate([
            fillLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            fillLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            
            phoneTextField.leadingAnchor.constraint(equalTo: fillLabel.leadingAnchor),
            phoneTextField.topAnchor.constraint(equalTo: fillLabel.bottomAnchor, constant: 8),
            phoneTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            phoneTextField.heightAnchor.constraint(equalToConstant: 48),
        
            addressTextField.leadingAnchor.constraint(equalTo: fillLabel.leadingAnchor),
            addressTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 8),
            addressTextField.trailingAnchor.constraint(equalTo: phoneTextField.trailingAnchor),
            addressTextField.heightAnchor.constraint(equalToConstant: 48),
            
            districtTextField.leadingAnchor.constraint(equalTo: fillLabel.leadingAnchor),
            districtTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 8),
            districtTextField.trailingAnchor.constraint(equalTo: phoneTextField.trailingAnchor),
            districtTextField.heightAnchor.constraint(equalToConstant: 48),
            
            cityTextField.leadingAnchor.constraint(equalTo: fillLabel.leadingAnchor),
            cityTextField.topAnchor.constraint(equalTo: districtTextField.bottomAnchor, constant: 8),
            cityTextField.trailingAnchor.constraint(equalTo: phoneTextField.trailingAnchor),
            cityTextField.heightAnchor.constraint(equalToConstant: 48),
            
            mapButton.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 15),
            mapButton.trailingAnchor.constraint(equalTo: cityTextField.trailingAnchor),
            mapButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupTargets() {
        mapButton.addTarget(self, action: #selector(handleMap), for: .primaryActionTriggered)
    }
        
    @objc func handleMap() {
        mapClosure?()
    }
    
}
