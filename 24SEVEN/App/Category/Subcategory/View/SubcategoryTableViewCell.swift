//
//  SubcategoryTableViewCell.swift
//  24SEVEN
//
//  Created by Islom on 08/02/21.
//

import UIKit

class SubcategoryTableViewCell : UITableViewCell{
    
    let subcategoryLabel = UILabel.makeLabel(string: "Овощи", size: .m, weight: .regular, alignment: .left)
    
    let numberOfItemsView = NumberOfItemsView()
    
    let spacerView = IBView()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.style()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        backgroundColor = .clear
        selectionStyle = .none
        
        spacerView.backgroundColor = UIColor(hex: "#9B9B9BFF")
        
        subcategoryLabel.textColor = UIColor.mainTextColor
    }
    
    private func layout() {
        contentView.addSubview(subcategoryLabel)
        contentView.addSubview(numberOfItemsView)
        contentView.addSubview(spacerView)
        
        NSLayoutConstraint.activate([
            subcategoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            subcategoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            subcategoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            numberOfItemsView.centerYAnchor.constraint(equalTo: subcategoryLabel.centerYAnchor),
            numberOfItemsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            numberOfItemsView.widthAnchor.constraint(equalToConstant: 48),
            numberOfItemsView.heightAnchor.constraint(equalToConstant: 24),
            
            spacerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            spacerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            spacerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            spacerView.heightAnchor.constraint(equalToConstant: 0.2)
        ])
    }
    
}
