//
//  LoginView.swift
//  24SEVEN
//
//  Created by Islom on 20/02/21.
//

import UIKit

class LoginView : GenericScrollView {
    
    let logo = LogoView()
    
    let phoneTextField = FillTextField(placeholder: "Введите номер телефона", type: .phone)
    
    let targetView = TargetButtonView(title: "ПОЛУЧИТЬ СМС-КОД")
    
    let authorize = AuthorizeView()
    
    let dismissButton = UIButton.makeButton(imageName: "dismiss")
    
    var dismissHandler: (() -> Void)?
    
    var receiveSmsClosure: ((String) -> Void)?
    
    var authorizeClosure: ((String) -> Void)?
    
    override init() {
        super.init()
        
        style()
        layout()
        setupTargets()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        navBarView.title = "title_activity_auth".localized(using: "Localizable")
        authorize.isHidden = true
        
        dismissButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        dismissButton.tintColor = UIColor.defaultOrange
        dismissButton.isHidden = true
    }
    
    private func addTarget() {
        dismissButton.addTarget(self, action: #selector(dismissAction), for: .primaryActionTriggered)
    }
    
    @objc func dismissAction() {
        dismissHandler?()
    }
    
    private func layout() {
        scrollContent.addSubview(logo)
        scrollContent.addSubview(phoneTextField)
        scrollContent.addSubview(targetView)
        scrollContent.addSubview(authorize)
        navBarView.addSubview(dismissButton)
        
        NSLayoutConstraint.activate([
            
            dismissButton.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor, constant: -4),
            dismissButton.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor, constant: 8),
            dismissButton.heightAnchor.constraint(equalToConstant: 36),
            dismissButton.widthAnchor.constraint(equalToConstant: 36),
            
            logo.topAnchor.constraint(equalTo: scrollContent.topAnchor),
            logo.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            logo.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            
            phoneTextField.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 32),
            phoneTextField.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor, constant: 16),
            phoneTextField.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor, constant: -16),
            phoneTextField.heightAnchor.constraint(equalToConstant: 48),
            
            targetView.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 32),
            targetView.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            targetView.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            targetView.bottomAnchor.constraint(lessThanOrEqualTo: scrollContent.bottomAnchor),
            
            authorize.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor),
            authorize.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            authorize.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            authorize.bottomAnchor.constraint(lessThanOrEqualTo: scrollContent.bottomAnchor, constant: -24),
        ])
    }
    
    private func setupTargets() {
        targetView.targetButton.addTarget(self, action: #selector(handleSms), for: .primaryActionTriggered)
        authorize.authButton.targetButton.addTarget(self, action: #selector(handleAuth), for: .primaryActionTriggered)
    }
    
    @objc func handleSms() {
        self.targetView.isHidden = true
        self.authorize.isHidden = false
        
        receiveSmsClosure?(phoneTextField.text ?? "")
    }
    
    @objc func handleAuth() {
        authorizeClosure?(authorize.enterCodeTextField.text ?? "")
    }
}

