//
//  FeedbackView.swift
//  24SEVEN
//
//  Created by Islom on 11/02/21.
//

import UIKit

class FeedbackView : IBView {
    
    let titleLabel = UILabel.makeLabel(string: "feedbacks".localized(using: "Localizable"), size: .l, weight: .bold, alignment: .left)
    
    let sendButton = UIButton.makeButton(title: "leave_feedback".localized(using: "Localizable"), size: .m, weight: .regular)
    
    var tableView: ContentSizedTableView = {
        let tableView = ContentSizedTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(FeedbackTableViewCell.self, forCellReuseIdentifier: FeedbackTableViewCell.reuseId)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    var handleFeedback: (() -> Void)?
    
    override init() {
        super.init()
        
        style()
        layout()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        titleLabel.textColor = UIColor.mainTextColor
        
        sendButton.setTitleColor(UIColor.defaultOrange, for: .normal)
        
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 20.0
    }
    
    private func layout() {
        addSubview(titleLabel)
        addSubview(sendButton)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17),
            
            sendButton.topAnchor.constraint(equalTo: topAnchor),
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -22),
        ])
    }
    
    private func setupTargets() {
        sendButton.addTarget(self, action: #selector(feedbackTapped), for: .primaryActionTriggered)
    }
    
    @objc func feedbackTapped() {
        handleFeedback?()
    }
}
