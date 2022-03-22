
protocol LoginViewModelProtocol: AnyObject {
    func getUserPhone()
}

class LoginViewModel {
    weak var delegate: LoginViewModelProtocol?
    
    fileprivate(set) var response: LoginResponse?
    fileprivate(set) var responseError: LoginErrorResponse?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func phoneLogin(phoneNumber: Int) {
        networkManager.loginPhone(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.response = response
                strongSelf.delegate?.getUserPhone()
            case .failure(let error):
                
                print(error.localizedDescription)
            }
        }, phone: phoneNumber)
    }
}
