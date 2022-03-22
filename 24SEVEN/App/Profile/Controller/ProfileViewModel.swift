
protocol ProfileViewModelProtocol: AnyObject {
    func updateUserInfo()
}

class ProfileViewModel {
    weak var delegate: ProfileViewModelProtocol?
    
    fileprivate(set) var userData: ProfileUser?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func profilePage() {
        networkManager.fetchUserInfo { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.userData = response
                strongSelf.delegate?.updateUserInfo()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
