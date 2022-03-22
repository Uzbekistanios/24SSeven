//
//  AuthorizeView.swift
//  24SEVEN
//
//  Created by Islom on 20/02/21.
//

import UIKit

class AuthorizeView : IBView {
    
    let sendMoreButton = UIButton.makeButton(title: "send_code_again".localized(using: "Localizable"), size: .m, weight: .regular)
    
    let enterCodeTextField = FillTextField(placeholder: "Введите Смс-код", type: .smsCode)
    
    let authButton = TargetButtonView(title: "АВТОРИЗОВАТЬСЯ")
    
    var sendMoreHandler: (() -> Void)?

    override init() {
        super.init()
        
        style()
        layout()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        sendMoreButton.setTitleColor(.systemGray, for: .normal)
    }
    
    private func addTarget() {
        sendMoreButton.addTarget(self, action: #selector(sendMoreAction), for: .primaryActionTriggered)
    }
    
    @objc func sendMoreAction() {
        self.sendMoreButton.isEnabled = false
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.sendMoreButton.isEnabled = true
        }
       
        sendMoreHandler?()
    }
    
    private func layout() {
        addSubview(sendMoreButton)
        addSubview(enterCodeTextField)
        addSubview(authButton)
        
        NSLayoutConstraint.activate([
            sendMoreButton.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            sendMoreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            enterCodeTextField.topAnchor.constraint(equalTo: sendMoreButton.bottomAnchor, constant: 24),
            enterCodeTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            enterCodeTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            enterCodeTextField.heightAnchor.constraint(equalToConstant: 48),
            
            authButton.topAnchor.constraint(equalTo: enterCodeTextField.bottomAnchor, constant: 32),
            authButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            authButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            authButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
