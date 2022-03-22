//
//  SettingsViewController.swift
//  24SEVEN
//
//  Created by Islom on 19/02/21.
//

import UIKit


class SettingsViewController : HideBottomBarViewController {
    
    let _view = SettingsView()
    var genderType: Int = 0
    
    var viewModel = ProfileViewModel()
    var viewModelUpdate = SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupTableView()
        setupButton()
    }
    
    override func loadView() {
        view = _view
    }
}

extension SettingsViewController {
    
    private func setupViewModel() {
        if AuthManager.shared.isAuthenticated() {
            viewModel.delegate = self
            viewModel.profilePage()
        }
    }
    
    private func setupTableView() {
        _view.selectGender.tableView.register(PaymentTypeRadioButtonCell.self, forCellReuseIdentifier: PaymentTypeRadioButtonCell.reuseId)
        _view.selectGender.tableView.delegate = self
        _view.selectGender.tableView.dataSource = self
    }
    
    private func setupButton() {
        _view.targetView.targetClosure = { [weak self] in
            guard let self = self else {
                return
            }
            
            if self._view.personalData.nameTextField.text?.count == 0 ||
                self._view.personalData.surNameTextField.text?.count == 0 ||
                self._view.personalData.dobTextField.text?.count == 0 {
                self.simpleTextSnackBar(title: "no_empty".localized(using: "Localizable"))
            } else {
                print(self.genderType)
                self.viewModelUpdate.delegate = self
                self.viewModelUpdate.profileUpdate(firstName: self._view.personalData.nameTextField.text ?? "", secondName: self._view.personalData.surNameTextField.text ?? "", birthDate: self._view.personalData.dobTextField.text ?? "", gender: self.genderType)
            }
        }
        
        _view.selectGender.chooseLanguageHandler = { [weak self] in
            guard let self = self else { return }
            self.displaySort()
        }
    }
    
    private func displaySort() {
        let sortVC = ChooseLanguageViewController()
        sortVC.modalPresentationStyle = .custom
        sortVC.transitioningDelegate = self
        sortVC.delegate = self
        self.present(sortVC, animated: true)
    }
    
}

extension SettingsViewController : ProfileViewModelProtocol {
    func updateUserInfo() {
        _view.personalData.nameTextField.text = viewModel.userData?.firstName
        _view.personalData.surNameTextField.text = viewModel.userData?.lastName
        _view.personalData.phoneTextField.text = "+\(viewModel.userData?.phone?.description ?? "")"
        _view.personalData.dobTextField.text = viewModel.userData?.birthDay
        _view.selectGender.tableView.reloadData()
    }
}

extension SettingsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PaymentTypeRadioButtonCell.reuseId) as? PaymentTypeRadioButtonCell else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = .mainBackgroundColor
        cell.radioText.text = MockData.gender[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        tableView.cellForRow(at: indexPath)?.setSelected(true, animated: true)
        if indexPath.row == 1 { genderType = 1 } else { genderType = 0 }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        return indexPath
    }
}


extension SettingsViewController : SettingsViewModelProtocol {
    func updateUser() {
        self.simpleTextSnackBar(title: "changed_success".localized(using: "Localizable"))
        popVC()
    }
}


extension SettingsViewController : ChooseLanguageViewControllerDelegate {
    func didSelectSortOption(option: String, index: Int) {
        if option == "Uzbek" {
            LanguageManager.shared.language = Language.Uzbek
        } else {
            LanguageManager.shared.language = Language.Russian
        }
        
        restartApplication()
    }
}

extension SettingsViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentController = PresentationController(presentedViewController: presented, presenting: presenting)
        presentController.forSettings = true
        return presentController
    }
}

//if UserPreferences.shared.currentLanguage != option {
//    if option == "Uzbek" {
//        LanguageManager.shared.language = Language.Uzbek
//    } else {
//        LanguageManager.shared.language = Language.Russian
//    }
//
//    restartApplication()
//}
