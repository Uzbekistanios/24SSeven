//
//  NavBarView.swift
//  24SEVEN
//
//  Created by Islom on 12/01/21.
//

import UIKit

class NavBarView: IBView {
    
    var backButton: UIButton = UIButton.makeNavBarButton()
  
   
    var titleLabel = UILabel.makeLabel(string: "24SEVEN", size: .xl,alignment: .center)
    var logoImageView = UIImageView.makeImageView(imageName: Constants.logo)
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    override init() {
        super.init()
        addSubview(logoImageView)
        addSubview(backButton)
        addSubview(titleLabel)
        
        setupStuff()
        
        let titleLabelBottomConstraint = titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        titleLabelBottomConstraint.priority = UILayoutPriority(rawValue: 749)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabelBottomConstraint,
            
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
        ])
    }
    
    private func setupStuff() {
        titleLabel.numberOfLines = 1
        titleLabel.minimumScaleFactor = 0.7
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
