//
//  AddAddressView.swift
//  24SEVEN
//
//  Created by Islom on 17/02/21.
//

import UIKit

class AddAddressView: GenericScrollView {
    
    let addressTextFields = AddressTextFieldsView()
    
    let targetView = TargetButtonView(title: "save_address".localized(using: "Localizable").uppercased())
    
    var mode : AddAddressMode? {
        didSet {
            guard let mode = mode else { return }
            switch mode {
            case .edit:
                addressTextFields.deleteAdressOption.isHidden = false
                navBarView.title = "Изменение адреса"
            case .add:
                addressTextFields.deleteAdressOption.isHidden = true
                navBarView.title = "add_address".localized(using: "Localizable")
            }
        }
    }
    
    override init() {
        super.init()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func layout() {
        scrollContent.addSubview(addressTextFields)
        scrollContent.addSubview(targetView)
        
        NSLayoutConstraint.activate([
            addressTextFields.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            addressTextFields.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            addressTextFields.topAnchor.constraint(equalTo: scrollContent.topAnchor),
            addressTextFields.bottomAnchor.constraint(lessThanOrEqualTo: targetView.topAnchor, constant: -12),
            
            targetView.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            targetView.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            targetView.bottomAnchor.constraint(equalTo: scrollContent.bottomAnchor, constant: -12)
        ])
    }
  
}

