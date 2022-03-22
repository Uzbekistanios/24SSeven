
import UIKit

protocol AddressViewControllerDelegate : AnyObject {
    func didRecieveAddress(nameAddress: String, addressID: Int, address: String, district: String, city: String)
}

class AddressViewController : HideBottomBarViewController {
    
    let _view = AddressView()
    
    var countOfAddresses : Int?
    
    var presentedView = false
    
    weak var delegate: AddressViewControllerDelegate?
    
    let viewModel = AddressViewModel()
    
    var lastSeenData: [AddressItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupClosures()
        checkForPresentedView()
    }
    
    override func loadView() {
        view = _view
    }
}

extension AddressViewController {
    private func setupTableView() {
        _view.tableView.delegate = self
        _view.tableView.dataSource = self
    }
    
    private func checkForPresentedView() {
        if presentedView == true {
            _view.dismissButton.isHidden = false
            _view.targetView.isHidden = true
            
            _view.dismissHandler = { [weak self] in
                guard let self = self else {
                    return
                }
                self.dismiss(animated: true, completion: nil)
            }
            
        } else {
            _view.dismissButton.isHidden = true
        }
    }
    
    private func setupClosures() {
        addAddress()
        viewModel.delegate = self
        viewModel.fetchAddresses(page: 1)
    }
    
    private func addAddress() {
        _view.targetView.targetClosure = { [weak self] in
            guard let self = self else { return }
            let vc = AddAddressViewController(mode: .add)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func editAddress(cell: AddressTableViewCell) {
        cell.editClosure = { [weak self] cell in
            guard let self = self else { return }
            let vc = AddAddressViewController(mode: .edit)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension AddressViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.addressItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.reuseId, for: indexPath) as? AddressTableViewCell else { return UITableViewCell()}
        
        if let pagination = viewModel.pagination {
            if countOfAddresses == indexPath.row + 1 && pagination.nextPage != nil {
                viewModel.delegate = self
                viewModel.fetchAddresses(page: pagination.nextPage ?? 1)
            }
        }
        
        cell.addressDescriptionView.addressLabel.text = viewModel.addressItems?[indexPath.row].name
        cell.addressDescriptionView.infoLabel.text = viewModel.addressItems?[indexPath.row].address
        
        editAddress(cell: cell)
        return cell
    }
    
}

extension AddressViewController: AddressViewModelProtocol {
    func updateAddressPage() {
        countOfAddresses = viewModel.items?.count
        
        if presentedView == true {
            if countOfAddresses == 0 {
                dismiss(animated: true, completion: nil)
                self.simpleTextSnackBar(title: "no_addresses_found".localized(using: "Localizable"))
            }
        }
        
        _view.tableView.reloadData()
    }
}

extension AddressViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if presentedView == true {
            delegate?.didRecieveAddress(nameAddress: viewModel.addressItems?[indexPath.row].name ?? "", addressID: viewModel.addressItems?[indexPath.row].id ?? -1, address:  viewModel.addressItems?[indexPath.row].address ?? "", district: viewModel.addressItems?[indexPath.row].region ?? "", city: viewModel.addressItems?[indexPath.row].city ?? "")
            dismiss(animated: true, completion: nil)
        }
        
        let vc = AddAddressViewController(mode: .edit)
        vc.currentIDEdit = viewModel.addressItems?[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
