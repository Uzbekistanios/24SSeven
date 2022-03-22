//
//  RadioButton.swift
//  24SEVEN
//
//  Created by Islom on 12/02/21.
//

import UIKit

class PaymentTypesView : IBView {
    
    var isSelected : Bool = false
    
    let transparentButton = UIButton.makeButton()
    
    let radioButton = RadioButtonView(outer: 20, inner: 10)
    
    var paymentImageView: UIImageView? = nil
    
    var paymentTitle: UILabel? = nil
    
        
    init(imageName: String? = nil, title: String? = nil, selected: Bool = false) {
        if let imageName = imageName {
            paymentImageView = UIImageView.makeImageView(imageName: imageName)
        }

        if let title = title {
            paymentTitle = UILabel.makeLabel(string: title, size: .l, weight: .regular, alignment: .center)
            paymentTitle?.textColor = UIColor.mainTextColor
        }
        
        isSelected = selected
        
        super.init()
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        if isSelected {
            radioButton.innerEllipse.isHidden = false
        } else {
            radioButton.innerEllipse.isHidden = true
        }
        
        transparentButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    
    private func layout() {
        addSubview(radioButton)
        addSubview(transparentButton)
        
        NSLayoutConstraint.activate([
            radioButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            radioButton.topAnchor.constraint(equalTo: topAnchor),
            radioButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            transparentButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            transparentButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            transparentButton.topAnchor.constraint(equalTo: topAnchor),
            transparentButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        if let image = paymentImageView {
            addSubview(image)
            NSLayoutConstraint.activate([
                image.leadingAnchor.constraint(equalTo: radioButton.trailingAnchor, constant: 10),
                image.topAnchor.constraint(equalTo: topAnchor),
                image.bottomAnchor.constraint(equalTo: bottomAnchor),
                image.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        }
        if let title = paymentTitle {
            addSubview(title)
            NSLayoutConstraint.activate([
                title.leadingAnchor.constraint(equalTo: radioButton.trailingAnchor, constant: 10),
                title.topAnchor.constraint(equalTo: topAnchor),
                title.bottomAnchor.constraint(equalTo: bottomAnchor),
                title.trailingAnchor.constraint(equalTo: trailingAnchor)  
            ])
        }
    }

}

