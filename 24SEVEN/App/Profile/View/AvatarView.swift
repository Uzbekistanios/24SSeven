//
//  AvatarView.swift
//  24SEVEN
//
//  Created by Islom on 13/02/21.
//

import UIKit

class AvatarView : IBView {
    
    let avatarImageView = UIImageView.makeImageView(imageName: "smallLogo")
    
    let nameLabel = UILabel.makeLabel(string: "", size: .l, weight: .bold, alignment: .left)
    
    let phoneLabel = UILabel.makeLabel(string: "", size: .m, weight: .regular, alignment: .left)
    
    let logoutButton = UIButton.makeButton(title: "logout".localized(using: "Localizable"), size: .m, weight: .regular, imageName: "LogOut", bottomText: false)
    
    var logoutHandler: (() -> Void)?
    
    override init() {
        super.init()
        
        style()
        layout()
        buttonSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func buttonSetup() {
        logoutButton.addTarget(self, action: #selector(logOutAction), for: .primaryActionTriggered)
    }
    
    @objc func logOutAction() {
        logoutHandler?()
    }
    
    private func style() {
        nameLabel.textColor = UIColor.mainTextColor
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.layer.cornerRadius = 32
        phoneLabel.textColor = .systemGray
        avatarImageView.tintColor = .black
        avatarImageView.isHidden = true
        logoutButton.isHidden = true
        logoutButton.tintColor = UIColor.defaultOrange
        
        logoutButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        logoutButton.imageEdgeInsets = UIEdgeInsets(top: -12, left: 17, bottom: 25, right: 0)
        logoutButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -25, bottom: -20, right: 8)
    }
    
    private func layout() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(phoneLabel)
        addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 64),
            avatarImageView.widthAnchor.constraint(equalToConstant: 64),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 18),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: logoutButton.leadingAnchor, constant: -6),
            
            phoneLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            phoneLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            logoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            logoutButton.widthAnchor.constraint(equalToConstant: 60),
            logoutButton.heightAnchor.constraint(equalToConstant: 60),
            logoutButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ])
    }
}
