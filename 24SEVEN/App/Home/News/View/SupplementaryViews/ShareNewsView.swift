//
//  ShareNewsView.swift
//  24SEVEN
//
//  Created by Islom on 20/02/21.
//

import UIKit

class ShareNewsView : IBView {
    
    let shareLabel = UILabel.makeLabel(string: "share".localized(using: "Localizable"), size: .l, weight: .bold, alignment: .center)
    
    let telegram = UIButton.makeButton(imageName: Constants.telegram)
    
    let facebook = UIButton.makeButton(imageName: Constants.facebook)
    
    let instagram = UIButton.makeButton(imageName: Constants.instagram)
    
    let buttonShare = UIButton.makeButton()
    
    var shareViewHandler: (() -> Void)?
    
    override init() {
        super.init()
        
        style()
        layout()
        buttonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        telegram.backgroundColor = .clear
        telegram.tintColor = UIColor.defaultOrange
        
        facebook.backgroundColor = .clear
        facebook.tintColor = UIColor.defaultOrange
        
        instagram.backgroundColor = .clear
        instagram.tintColor = UIColor.defaultOrange
    }
    
    private func buttonActions() {
        buttonShare.addTarget(self, action: #selector(openTelegram), for: .primaryActionTriggered)
    }
    
    @objc func openTelegram() {
        shareViewHandler?()
    }
    
  
    private func layout() {
        addSubview(shareLabel)
        addSubview(telegram)
        addSubview(facebook)
        addSubview(instagram)
        addSubview(buttonShare)
        
        NSLayoutConstraint.activate([
            telegram.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            telegram.topAnchor.constraint(equalTo: topAnchor),
            telegram.bottomAnchor.constraint(equalTo: bottomAnchor),
            telegram.heightAnchor.constraint(equalToConstant: 16),
            telegram.widthAnchor.constraint(equalToConstant: 16),
            
            facebook.trailingAnchor.constraint(equalTo: telegram.leadingAnchor, constant: -8),
            facebook.centerYAnchor.constraint(equalTo: telegram.centerYAnchor),
            facebook.heightAnchor.constraint(equalToConstant: 16),
            facebook.widthAnchor.constraint(equalToConstant: 16),
            
            instagram.trailingAnchor.constraint(equalTo: facebook.leadingAnchor, constant: -8),
            instagram.centerYAnchor.constraint(equalTo: telegram.centerYAnchor),
            instagram.heightAnchor.constraint(equalToConstant: 16),
            instagram.widthAnchor.constraint(equalToConstant: 16),
            
            buttonShare.leadingAnchor.constraint(equalTo: shareLabel.leadingAnchor),
            buttonShare.topAnchor.constraint(equalTo: shareLabel.topAnchor),
            buttonShare.bottomAnchor.constraint(equalTo: shareLabel.bottomAnchor),
            buttonShare.trailingAnchor.constraint(equalTo: telegram.trailingAnchor),
        
            shareLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            shareLabel.trailingAnchor.constraint(equalTo: instagram.leadingAnchor, constant: -8),
            shareLabel.centerYAnchor.constraint(equalTo: telegram.centerYAnchor),
        ])
    }
}
