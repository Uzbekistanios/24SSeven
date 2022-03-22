//
//  SelectorView.swift
//  24SEVEN
//
//  Created by Islom on 11/02/21.
//

import UIKit

class SelectorView : IBView {
    
    let decrementButton = UIButton.makeButton(imageName: Constants.decrementButton, insets: true, cornerRadius: 18.0)
    
    let quantityLabel = UILabel.makeLabel(string: "2 кг", size: .l, weight: .semibold, alignment: .center)
    
    let incrementButton = UIButton.makeButton(imageName: Constants.incrementButton, insets: true, cornerRadius: 18.0)
    
    var incrementHandler: (() -> Void)?
    var decrementHandler: (() -> Void)?
    
    override init() {
        super.init()
        
        style()
        layout()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func style() {
        decrementButton.backgroundColor = UIColor.mainSubviewColor
        decrementButton.tintColor = .gray
        
        quantityLabel.layer.masksToBounds = true
        quantityLabel.layer.cornerRadius = 20.0
        quantityLabel.backgroundColor = UIColor.mainSubviewColor
        quantityLabel.layer.borderWidth = 0.2
        quantityLabel.layer.borderColor = UIColor.gray.cgColor
        quantityLabel.minimumScaleFactor = 0.6
        
        incrementButton.backgroundColor = UIColor.mainSubviewColor
        incrementButton.tintColor = .gray
    }
    
    private func layout() {
        addSubview(decrementButton)
        addSubview(quantityLabel)
        addSubview(incrementButton)
        
        NSLayoutConstraint.activate([
            decrementButton.centerYAnchor.constraint(equalTo: quantityLabel.centerYAnchor),
            decrementButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            decrementButton.heightAnchor.constraint(equalToConstant: 36),
            decrementButton.widthAnchor.constraint(equalToConstant: 36),
            
            quantityLabel.topAnchor.constraint(equalTo: topAnchor),
            quantityLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            quantityLabel.leadingAnchor.constraint(equalTo: decrementButton.trailingAnchor, constant: 6),
            quantityLabel.trailingAnchor.constraint(equalTo: incrementButton.leadingAnchor, constant: -6),
            quantityLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            quantityLabel.heightAnchor.constraint(equalToConstant: 36),
            quantityLabel.widthAnchor.constraint(equalToConstant: 80),
            
            incrementButton.centerYAnchor.constraint(equalTo: quantityLabel.centerYAnchor),
            incrementButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            incrementButton.heightAnchor.constraint(equalToConstant: 36),
            incrementButton.widthAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    private func setupTargets() {
        decrementButton.addTarget(self, action: #selector(decrementValueAction), for: .primaryActionTriggered)
        incrementButton.addTarget(self, action: #selector(incrementValueAction), for: .primaryActionTriggered)
    }

    @objc func incrementValueAction() {
       incrementHandler?()
    }

    @objc func decrementValueAction() {
        decrementHandler?()
    }
}
