//
//  FilterDetailsTableViewCell.swift
//  24SEVEN
//
//  Created by Islom on 26/02/21.
//

import UIKit

class FilterDetailsTableViewCell : UITableViewCell {
    
    let itemLabel = UILabel.makeLabel(string: "Coca cola", size: .l, weight: .regular, alignment: .center)
    
    let checkmarkButton = UIButton.makeButton(imageName: "Checkmark-off")
    
    var checked: Bool? {
        didSet {
            guard let checked = checked else { return }
            if checked {
                itemLabel.textColor = UIColor.defaultOrange
                
                checkmarkButton.backgroundColor = UIColor.defaultOrange
                checkmarkButton.tintColor = UIColor.defaultOrange
                checkmarkButton.setBackgroundImage(UIImage(named: "CheckmarkOrange-on"), for: .normal)
                checkmarkButton.layer.borderColor = UIColor.clear.cgColor
            } else {
                itemLabel.textColor = UIColor.mainTextColor
                checkmarkButton.setBackgroundImage(UIImage(named: "Checkmark-off"), for: .normal)
                checkmarkButton.backgroundColor = .clear
                checkmarkButton.setImage(nil, for: .normal)
                checkmarkButton.layer.borderColor = UIColor.systemGray.cgColor
            }
        }
    }
    
    var selectClosure: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.style()
        self.layout()
        self.setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        backgroundColor = .clear
        selectionStyle = .none
        
        checkmarkButton.layer.borderWidth = 1
        checkmarkButton.layer.borderColor = UIColor.systemGray.cgColor
        checkmarkButton.layer.cornerRadius = 4.0
        checkmarkButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 2, bottom: 4, right: 3)
    }
    
    private func layout() {
        contentView.addSubview(itemLabel)
        contentView.addSubview(checkmarkButton)
        
        NSLayoutConstraint.activate([
            itemLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            itemLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            checkmarkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkmarkButton.centerYAnchor.constraint(equalTo: itemLabel.centerYAnchor),
            checkmarkButton.heightAnchor.constraint(equalToConstant: 20),
            checkmarkButton.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func setupTargets() {
        checkmarkButton.addTarget(self, action: #selector(handleSelect), for: .primaryActionTriggered)
    }
    
    @objc func handleSelect() {
        selectClosure?()
    }
}
