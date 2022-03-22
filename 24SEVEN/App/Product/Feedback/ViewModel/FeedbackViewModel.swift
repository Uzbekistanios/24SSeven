

protocol FeedbackViewModelProtocol: AnyObject {
    func addComment()
}

class FeedbackViewModel {
    weak var delegate: FeedbackViewModelProtocol?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func addComment(productId: Int, firstName: String, body: String) {
        networkManager.addItemComment(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
               print(response)
                strongSelf.delegate?.addComment()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, productId: productId, firstName: firstName, body: body)
    }
}
