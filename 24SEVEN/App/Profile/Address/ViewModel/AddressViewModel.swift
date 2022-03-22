
protocol AddressViewModelProtocol: AnyObject {
    func updateAddressPage()
}

class AddressViewModel {
    weak var delegate: AddressViewModelProtocol?
    var addressItems : [AddressItem]? = []
    
    fileprivate(set) var items: [AddressItem]? = []
    fileprivate(set) var pagination: AddressPagination?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchAddresses(page: Int) {
        networkManager.fetchUserAddresses(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.items = response.items
                strongSelf.pagination = response.pagination
                strongSelf.addressItems?.append(contentsOf: response.items ?? [])
                strongSelf.delegate?.updateAddressPage()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, page: page)
    }
}
