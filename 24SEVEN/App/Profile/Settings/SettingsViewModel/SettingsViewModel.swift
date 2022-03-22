
protocol SettingsViewModelProtocol: AnyObject {
    func updateUser()
}

class SettingsViewModel {
    weak var delegate: SettingsViewModelProtocol?
    
    fileprivate(set) var userData: ProfileUser?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func profileUpdate(firstName: String, secondName: String, birthDate: String, gender: Int) {
        networkManager.profileUpdate(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.userData = response
                strongSelf.delegate?.updateUser()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, firstName: firstName, secondName: secondName, birthDate: birthDate, gender: gender)
    }
}
