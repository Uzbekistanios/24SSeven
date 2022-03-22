//
//  FeedbackTableViewCell.swift
//  24SEVEN
//
//  Created by Islom on 11/02/21.
//

import UIKit


class FeedbackTableViewCell : UITableViewCell {
    
    let usernameLabel = UILabel.makeLabel(string: "Eshonov Eshmat", size: .l, weight: .bold, alignment: .left)
    
    let feedbackLabel = UILabel.makeLabel(string: "Очень вкусный помидор", size: .l, weight: .regular, alignment: .left)
    
    let dateLabel = UILabel.makeLabel(string: "05-12-2019", size: .m, weight: .regular, alignment: .right)
    
    let spacerView = IBView()
    
    var cellModel: CategoryComment? {
        didSet {
            guard let model = cellModel else {return}
            dateLabel.text = model.createdAt
            feedbackLabel.text = model.body
            usernameLabel.text = model.firstName
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.style()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func style() {
        selectionStyle = .none
        
        usernameLabel.textColor = UIColor.mainTextColor
        
        feedbackLabel.textColor = UIColor.mainTextColor
        
        feedbackLabel.numberOfLines = 0
        dateLabel.numberOfLines = 1
        usernameLabel.numberOfLines = 1
        
        dateLabel.textColor = .systemGray
        spacerView.backgroundColor = .clear
    }
    
    private func layout() {
        
        
        dateLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        dateLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        contentView.addSubview(usernameLabel)
        contentView.addSubview(feedbackLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(spacerView)
     
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -8),
            
            feedbackLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            feedbackLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 12),
            feedbackLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            
            dateLabel.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            spacerView.topAnchor.constraint(equalTo: feedbackLabel.bottomAnchor),
            spacerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            spacerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            spacerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            spacerView.heightAnchor.constraint(equalToConstant: 8)
            
        ])
    }
    
}
