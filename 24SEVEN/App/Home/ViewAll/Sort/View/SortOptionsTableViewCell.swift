//
//  SortOptionsTableViewCell.swift
//  24SEVEN
//
//  Created by Islom on 25/02/21.
//

import UIKit

class SortOptionsTableViewCell : UITableViewCell {
    
    let optionLabel = UILabel.makeLabel(string: "sort_by_new".localized(using: "Localizable"), size: .xl, weight: .bold, alignment: .left)
    
    let placeholderView = IBView()
    
    var title: String? {
        didSet {
            guard let title = title else { return }
            optionLabel.text = title
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
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func layout() {
        contentView.addSubview(placeholderView)
        
        placeholderView.addSubview(optionLabel)
        
        
        NSLayoutConstraint.activate([
            placeholderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            placeholderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            placeholderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            placeholderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -17),
            
            optionLabel.topAnchor.constraint(equalTo: placeholderView.topAnchor, constant: 15),
            optionLabel.bottomAnchor.constraint(equalTo: placeholderView.bottomAnchor, constant: -14),
            optionLabel.leadingAnchor.constraint(equalTo: placeholderView.leadingAnchor, constant: 16),
            optionLabel.trailingAnchor.constraint(equalTo: placeholderView.trailingAnchor, constant: -16)
        ])
    }
    
    func selectedState() {
        placeholderView.backgroundColor = UIColor(hex: "#10182BFF")
        optionLabel.textColor = UIColor.mainSubviewColor
    }
}
