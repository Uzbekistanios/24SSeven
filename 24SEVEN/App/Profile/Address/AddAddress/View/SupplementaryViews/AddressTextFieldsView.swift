//
//  AddressTextFieldsView.swift
//  24SEVEN
//
//  Created by Islom on 17/02/21.
//

import UIKit


class AddressTextFieldsView: IBView {
    
    let titleTextField = FillTextField(placeholder: "address_name".localized(using: "Localizable"))
    
    let addressTextField = FillTextField(placeholder: "address".localized(using: "Localizable"))
    
    let districtTextField = FillTextField(placeholder: "district".localized(using: "Localizable"))
    
    let cityTextField = FillTextField(placeholder: "city".localized(using: "Localizable"))
    
    let pinOnMapButton = UIButton.makeButton(title: "show_on_map".localized(using: "Localizable"), size: .m, weight: .regular, imageName: Constants.map, insets: true, imageInsets: true)
    
    let deleteAdressOption = UIButton.makeButton(title: "delete_address".localized(using: "Localizable"), size: .m, weight: .regular, insets: true, imageInsets: true)
    
    var deleteClosure: (() -> Void)?
    
    var pinMapClosure: (() -> Void)?
    
    override init() {
        super.init()
        
        style()
        layout()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupTargets() {
        pinOnMapButton.addTarget(self, action: #selector(pinMapAction), for: .primaryActionTriggered)
        deleteAdressOption.addTarget(self, action: #selector(deleteRowAction), for: .primaryActionTriggered)
    }
    
    @objc func pinMapAction() {
        pinMapClosure?()
    }
    
    @objc func deleteRowAction() {
        deleteClosure?()
    }
    
    private func style() {
        pinOnMapButton.tintColor = UIColor.defaultOrange
        deleteAdressOption.tintColor = UIColor.red
    }
    
    private func layout() {
        addSubview(titleTextField)
        addSubview(addressTextField)
        addSubview(pinOnMapButton)
        addSubview(districtTextField)
        addSubview(cityTextField)
        addSubview(deleteAdressOption)
        
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleTextField.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            titleTextField.heightAnchor.constraint(equalToConstant: 48),
            
            addressTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            addressTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addressTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 12),
            addressTextField.heightAnchor.constraint(equalToConstant: 48),
            
            districtTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 17),
            districtTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            districtTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            districtTextField.heightAnchor.constraint(equalToConstant: 48),
            
            cityTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cityTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cityTextField.topAnchor.constraint(equalTo: districtTextField.bottomAnchor, constant: 12),
            cityTextField.heightAnchor.constraint(equalToConstant: 48),
            
            pinOnMapButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17),
            pinOnMapButton.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 13),
            pinOnMapButton.bottomAnchor.constraint(equalTo: deleteAdressOption.topAnchor, constant: -10),
            
            
            deleteAdressOption.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17),
            deleteAdressOption.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
        ])
    }
    
}

