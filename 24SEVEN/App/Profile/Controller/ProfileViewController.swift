//
//  ProfileViewController.swift
//  24SEVEN
//
//  Created by Islom on 13/02/21.
//

import UIKit

class ProfileViewController: GenericViewController {
    
    var viewModel = ProfileViewModel()
    var logOutVM = LogoutViewModel()
    let _view = ProfileView()
    var numberOfRows: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupLogout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        if AuthManager.shared.isAuthenticated() {
            setupViewModel()
        }
        
        _view.scrollView.refreshControl = UIRefreshControl()
        _view.scrollView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
      
    }
    
    override func loadView() {
        super.loadView()
        view = _view
    }
    
    @objc func refresh(){
        setupViewModel()
        DispatchQueue.main.async {
            self._view.scrollView.refreshControl?.endRefreshing()
        }
    }
    
    private func setupLogout() {
        _view.avatar.logoutHandler = { [weak self] in
            guard let self = self else { return }

            self.logOutVM.logOut()
            UserPreferences.shared.userToken = nil
            restartApplication()
          
            //self.logOutVM.delegate = self
        }
    }
}

extension ProfileViewController {
    
    private func setupViewModel() {
        if AuthManager.shared.isAuthenticated() {
            viewModel.delegate = self
            viewModel.profilePage()
        }
    }
    
    private func setupTableView() {
        _view.tableView.delegate = self
        _view.tableView.dataSource = self
    }
}

//MARK: - UITableViewDataSource
extension ProfileViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSettingsTableViewCell.reuseId, for: indexPath) as? ProfileSettingsTableViewCell else { return UITableViewCell() }
        
        cell.type = ProfileSection(rawValue: indexPath.row)
        switch indexPath.row {
        case 0: cell.descriptionLabel.text = "\(viewModel.userData?.ordersCount?.description ?? "") " + "order_count".localized(using: "Localizable")
        case 1: cell.descriptionLabel.text = "\(viewModel.userData?.favoritesCount?.description ?? "") " + "items_count".localized(using: "Localizable")
        case 2: cell.descriptionLabel.text = "\(viewModel.userData?.addressesCount?.description ?? "") " + "address_count".localized(using: "Localizable")
        default: break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
}

//MARK: - UITableViewDelegate
extension ProfileViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 3 {
            guard let section = ProfileSection(rawValue: indexPath.row) else { return }
            self.navigationController?.pushViewController(section.vc, animated: true)
        } else {
            simpleTextSnackBar(title: "not_available".localized(using: "Localizable"))
        }
      
    }
}

extension ProfileViewController : ProfileViewModelProtocol {
    func updateUserInfo() {
        numberOfRows = 5
        
        _view.avatar.avatarImageView.isHidden = false
        _view.avatar.logoutButton.isHidden = false
        
        if viewModel.userData?.avatar != nil {
            _view.avatar.avatarImageView.setImage(imageUrl: viewModel.userData?.avatar ?? "")
        }
        
        _view.avatar.nameLabel.text = "\(viewModel.userData?.lastName ?? "") \(viewModel.userData?.firstName ?? "")"
        _view.avatar.phoneLabel.text = viewModel.userData?.phone?.description
        
        _view.tableView.reloadData()
    }
}

extension ProfileViewController : LogoutViewModelProtocol {
    func logout() {
        UserPreferences.shared.userToken = nil
        restartApplication()
    }
}
