//
//  LoginViewController.swift
//  24SEVEN
//
//  Created by Islom on 20/02/21.
//

import UIKit
import Moya

class LoginViewController : HideBottomBarViewController {
    
    let _view = LoginView()
    let confirmViewModel = LoginVerifyViewModel()
    let viewModel = LoginViewModel()
    var userPhoneNumber: Int?
    var dissmissHidden: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _view.receiveSmsClosure = { [weak self] phoneNumber in
            if phoneNumber.count == 0 {
                self?.simpleTextSnackBar(title: "phone_empty".localized(using: "Localizable"))
                self?.dismiss(animated: true, completion: nil)
            } else {
                guard let self = self else { return }
                self.viewModel.delegate = self
                self.userPhoneNumber = Int(phoneNumber.removeAllSpaces().dropFirst())!
                self.viewModel.phoneLogin(phoneNumber: self.userPhoneNumber ?? 0)
            }
        }
        
        _view.authorize.sendMoreHandler = { [weak self] in
            if self?._view.phoneTextField.text == "" {
                self?.simpleTextSnackBar(title: "phone_empty".localized(using: "Localizable"))
                self?.dismiss(animated: true, completion: nil)
            } else {
                guard let self = self else { return }
                self.viewModel.delegate = self
                self.userPhoneNumber = Int(self._view.phoneTextField.text?.removeAllSpaces().dropFirst() ?? "")!
                self.viewModel.phoneLogin(phoneNumber: self.userPhoneNumber ?? 0)
            }
        }
        
        _view.authorizeClosure =  { [weak self] smsCode in
            guard let self = self else { return }
            self.confirmViewModel.delegate = self
            self.confirmViewModel.loginVerify(phoneNumber: self.userPhoneNumber ?? 0, verifyCode: Int(smsCode) ?? 0)
        }
        
        dismissButton()
    }
    
    override func loadView() {
        view = _view
    }
    
    
    private func dismissButton() {
        
        if dissmissHidden == true {
            _view.dismissButton.isHidden = true
        } else {
            _view.dismissButton.isHidden = false
        }
        
        _view.dismissHandler = { [weak self] in
            guard let self = self else {
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
}


extension LoginViewController: LoginViewModelProtocol {
    func getUserPhone() {
        simpleTextSnackBar(title: "sent_to_phone".localized(using: "Localizable") + "\(viewModel.response?.phone?.description ?? "")")
    }
}

extension LoginViewController : LoginVerifyViewModelProtocol {
    func verifyCode() {
        
        if confirmViewModel.response?.accessToken == nil {
            simpleTextSnackBar(title: "incorrent_phone".localized(using: "Localizable"))
        } else {
            simpleTextSnackBar(title: "register_success".localized(using: "Localizable"))
            UserPreferences.shared.userToken = confirmViewModel.response?.accessToken
            UserPreferences.shared.userPhone = viewModel.response?.phone?.description
            UserPreferences.shared.userName = confirmViewModel.response?.user?.firstName
            dismiss(animated: true, completion: nil)
            popVC()
        }
    }
}
