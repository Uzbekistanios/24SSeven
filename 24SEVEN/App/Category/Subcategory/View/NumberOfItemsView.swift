//
//  NumberOfItemsView.swift
//  24SEVEN
//
//  Created by Islom on 08/02/21.
//

import UIKit

class NumberOfItemsView : IBView {
    
    let numberOfItemsLabel = UILabel.makeLabel(string: "101", size: .m, weight: .regular, alignment: .center)
    
    override init() {
        super.init()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func style() {
        backgroundColor = UIColor.numOfItems
        layer.cornerRadius = 8.0
        
        numberOfItemsLabel.textColor = UIColor.defaultOrange
    }
    
    private func layout() {
        addSubview(numberOfItemsLabel)
    
        NSLayoutConstraint.activate([
            numberOfItemsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberOfItemsLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
