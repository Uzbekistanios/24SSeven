//
//  CategoryTableViewCell.swift
//  24SEVEN
//
//  Created by Islom on 08/02/21.
//

import UIKit

class CategoryTableViewCell : UITableViewCell {
    
    let categoryLabel = UILabel.makeLabel(string: "Еда", size: .xl, weight: .bold, alignment: .center)
    
    let categoryImageView = UIImageView.makeImageView(imageName: "CategoryImage")
    
    let stackView = IBStackView(axis: .horizontal, distribution: .fill, alignment: .fill)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.style()
        self.layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style(){
        selectionStyle = .none
        backgroundColor = .clear
        
        stackView.layer.masksToBounds = true
        stackView.layer.cornerRadius = 8.0
        
        categoryLabel.textColor = UIColor.mainTextColor
        categoryLabel.backgroundColor = UIColor.mainSubviewColor
    }
    
    private func layout() {
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(categoryImageView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
}
