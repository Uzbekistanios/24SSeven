//
//  ProfileView.swift
//  24SEVEN
//
//  Created by Islom on 13/02/21.
//

import UIKit

class ProfileView : GenericScrollView {
  
    let avatar = AvatarView()
    
    let tableView = IBTableView(cellClass: ProfileSettingsTableViewCell.self, reuseId: ProfileSettingsTableViewCell.reuseId)
    
    override init() {
        super.init()
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        
    }
    
    private func layout() {
        scrollContent.addSubview(avatar)
        scrollContent.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: scrollContent.topAnchor),
            avatar.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            avatar.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            avatar.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -44),
            
            tableView.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: scrollContent.bottomAnchor)
        ])
    }
    
}
