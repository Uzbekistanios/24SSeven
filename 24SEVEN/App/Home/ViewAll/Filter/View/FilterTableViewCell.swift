//
//  FilterTableViewCell.swift
//  24SEVEN
//
//  Created by Islom on 26/02/21.
//

import UIKit

class FilterTableViewCell : UITableViewCell {
    
    let categoryLabel = UILabel.makeLabel(string: "title_dashboard".localized(using: "Localizable"), size: .l, weight: .bold, alignment: .center)
    
    let itemLabel = UILabel.makeLabel(string: "Еда", size: .m, weight: .regular, alignment: .center)
    
    let spacerView = IBView()
    
    let placeholderView = IBView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.style()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        backgroundColor = .clear
        selectionStyle = .none
        
        itemLabel.textColor = .systemGray
        
        spacerView.backgroundColor = .systemGray
        
        placeholderView.backgroundColor = .clear
    }
    
    private func layout() {
        contentView.addSubview(placeholderView)
        
        placeholderView.addSubview(categoryLabel)
        placeholderView.addSubview(itemLabel)
        placeholderView.addSubview(spacerView)
        
        NSLayoutConstraint.activate([
            placeholderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            placeholderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            placeholderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            placeholderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            categoryLabel.leadingAnchor.constraint(equalTo: placeholderView.leadingAnchor, constant: 16),
            categoryLabel.topAnchor.constraint(equalTo: placeholderView.topAnchor),
            
            itemLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            itemLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            spacerView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 20),
            spacerView.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor),
            spacerView.trailingAnchor.constraint(equalTo: itemLabel.trailingAnchor),
            spacerView.heightAnchor.constraint(equalToConstant: 0.5),
            spacerView.bottomAnchor.constraint(equalTo: placeholderView.bottomAnchor)
        ])
    }
}
