
protocol LogoutViewModelProtocol: AnyObject {
    func logout()
}

class LogoutViewModel {
    weak var delegate: LogoutViewModelProtocol?
    
    fileprivate(set) var response: LoginResponse?
    fileprivate(set) var responseError: LoginErrorResponse?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func logOut() {
        networkManager.logout(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(_):
                strongSelf.delegate?.logout()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
