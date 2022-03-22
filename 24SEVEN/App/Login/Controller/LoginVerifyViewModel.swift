
import Moya

protocol LoginVerifyViewModelProtocol: AnyObject {
    func verifyCode()
}

class LoginVerifyViewModel {
    weak var delegate: LoginVerifyViewModelProtocol?
    
    fileprivate(set) var response: LoginVerifyModel?
   
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func loginVerify(phoneNumber: Int, verifyCode: Int) {
        networkManager.verifyPhone(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.response = response
                strongSelf.delegate?.verifyCode()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, phone: phoneNumber, verifyCode: verifyCode)
    }
}
