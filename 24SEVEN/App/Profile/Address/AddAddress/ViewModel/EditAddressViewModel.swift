
protocol EditAddressViewModelProtocol: AnyObject {
    func editAddress()
}

class EditAddressViewModel {
    weak var delegate: EditAddressViewModelProtocol?
    
    fileprivate(set) var response: EditAddress?
   
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func updateAddress(addressId: Int, name: String, address: String, city: String, region: String, locationLat: String, locationLang: String, phone: String) {
        networkManager.updateAddress(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.response = response
                strongSelf.delegate?.editAddress()
            case .failure(let error):
                print(error.localizedDescription)
            }
        },addressId: addressId, name: name, address: address, city: city, region: region, locationLat: locationLat, locationLang: locationLang, phone: phone)
    }
}
