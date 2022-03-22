//
//  TargetButtonView.swift
//  24SEVEN
//
//  Created by Islom on 12/02/21.
//

import UIKit

class TargetButtonView : IBView {
    
    let targetButton : UIButton
    
    var targetClosure: (() -> Void)?
    
    init(title: String, imageName: String? = nil, backgroundColor : UIColor? = UIColor.mainButtonBackgrounColor) {
        targetButton = UIButton.makeButton(title: title, size: .l, weight: .bold, imageName: imageName, insets: true, cornerRadius: 25.0, imageInsets: true)
      
        super.init()
        style(backgroundColor)
        layout()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    private func style(_ backgroundColor: UIColor?) {
        targetButton.setTitleColor(.white, for: .normal)
        targetButton.backgroundColor = backgroundColor
    }
    
    private func layout() {
        addSubview(targetButton)
        
        NSLayoutConstraint.activate([
            targetButton.topAnchor.constraint(equalTo: topAnchor),
            targetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            targetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            targetButton.heightAnchor.constraint(equalToConstant: 48),
            targetButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupTargets() {
        targetButton.addTarget(self, action: #selector(handleClosure), for: .primaryActionTriggered)
    }
    
    @objc func handleClosure() {
        targetClosure?()
    }
}
