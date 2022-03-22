
protocol AddAdressViewModelProtocol: AnyObject {
    func addedAddress()
}

class AddAdressViewModel {
    weak var delegate: AddAdressViewModelProtocol?
    
    fileprivate(set) var response: AddAdress?
   
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func addAddress(name: String, address: String, city: String, region: String, locationLat: String, locationLang: String, phone: String) {
        networkManager.addNewAddress(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.response = response
                strongSelf.delegate?.addedAddress()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, name: name, address: address, city: city, region: region, locationLat: locationLat, locationLang: locationLang, phone: phone)
    }
}
