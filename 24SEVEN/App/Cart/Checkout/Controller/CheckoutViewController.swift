
import UIKit

class CheckoutViewController : HideBottomBarViewController {
    
    var params = [String:String]()
    
    var priceInitial: Int = 0
    var priceDelivery: Int = 0
    var overallPrice: Int?
    var paymentType: String = "cash"
    
    var lat: String = "0.0"
    var long: String = "0.0"
    
    var checkOutID: Int = -1
    let viewController = AddressViewController()
    
    let viewModel = CheckoutViewModel()
    let viewModelWithID = CheckoutWithIDViewModel()
    let _view = CheckoutView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCheckout()
        setupTargets()
        setupTableView()
        addressViewAction()
    }
    
    override func loadView() {
        super.loadView()
        view = _view
    }
}

extension CheckoutViewController {
    
    private func setupCheckout() {
        
        overallPrice = priceInitial + priceDelivery
    
        _view.totalPriceView.initialPrice.priceLabel.text = "\(priceInitial) " + "money_format_sum".localized(using: "Localizable")
        _view.totalPriceView.deliveryPrice.priceLabel.text = "\(priceDelivery) " + "money_format_sum".localized(using: "Localizable")
        _view.totalPriceView.totalPrice.priceLabel.text = "\(overallPrice ?? 0) " + "money_format_sum".localized(using: "Localizable")
        
        if AuthManager.shared.isAuthenticated() {
            guard let userPhone = UserPreferences.shared.userPhone else { return }
            _view.fillView.phoneTextField.text = "+\(userPhone)"
        } else {
            _view.fillView.phoneTextField.text = ""
        }
        
        _view.fillView.mapClosure = { [weak self] in
            guard let self = self else { return }
            let navVC = YandexMapController()
            navVC.delegate = self
            self.navigationController?.pushViewController(navVC, animated: true)
        }
    }
    
    private func setupTableView() {

        _view.paymentView.tableView.delegate = self
        _view.paymentView.tableView.dataSource = self
        
    }
    
    private func setupTargets() {
        
        _view.targetButton.targetClosure = { [weak self] in
            guard let self = self else { return }
            if AuthManager.shared.isAuthenticated() {
                if self._view.fillView.addressTextField.text?.count == 0 ||
                    self._view.fillView.districtTextField.text?.count == 0 ||
                    self._view.fillView.cityTextField.text?.count == 0 ||
                    self._view.fillView.phoneTextField.text?.count == 0 {
                    self.simpleTextSnackBar(title: "no_empty".localized(using: "Localizable"))
                } else {
                    let successVC = SuccessViewController()
                    
                    let phoneNumber = self._view.fillView.phoneTextField.text?.removeAllSpaces().dropFirst() ?? ""
                    
                    if self.checkOutID == -1 {
                        self.viewModel.checkoutProcess(paymentType: self.paymentType, addressName: "MANUAL", addressMain: self._view.fillView.addressTextField.text ?? "", addressCity: self._view.fillView.cityTextField.text ?? "", addressRegion: self._view.fillView.districtTextField.text ?? "", phone: String(phoneNumber), locationLat: self.lat, locationLang: self.long, data: self.params)
                        self.viewModel.delegate = self
                    } else {
                        self.viewModelWithID.checkoutWithAddress(paymentType: self.paymentType, addressId: self.checkOutID, data: self.params)
                        self.viewModelWithID.delegate = self
                    }
                    
                    successVC.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(successVC, animated: true)
                }
            } else {
                let loginVC = LoginViewController()
                self.present(loginVC, animated: true, completion: nil)
            }
        }
    }
    
    private func addressViewAction() {
        _view.savedView.viewTouchListener = { [weak self] in
            guard let self = self else { return }
            self.viewController.modalPresentationStyle = .overCurrentContext
            self.viewController.modalTransitionStyle = .crossDissolve
            self.viewController.presentedView = true
            self.viewController.delegate = self
            self.present(self.viewController, animated: true, completion: nil)
        }
    }
}

extension CheckoutViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PaymentTypeRadioButtonCell.reuseId) as? PaymentTypeRadioButtonCell else {
            return UITableViewCell()
        }
        
        tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.setSelected(true, animated: true)
        
        cell.backgroundColor = .mainBackgroundColor
        cell.radioText.text = MockData.payment[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        tableView.cellForRow(at: indexPath)?.setSelected(true, animated: true)
        if indexPath.row == 1 {
            paymentType = "transfer"
        } else {
            paymentType = "cash"
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        return indexPath
    }
}

extension CheckoutViewController: YandexMapViewControllerDelegate {
    func didChanged(lat: String, long: String, adress: String, district: String, city: String) {
        _view.fillView.addressTextField.text = adress
        _view.fillView.districtTextField.text = district
        _view.fillView.cityTextField.text = city
        self.lat = lat
        self.long = long
    }
}

extension CheckoutViewController: CheckoutViewModelProtocol {
    func checkout() {
        if let findedBasket = uiRealm.objects(BasketModel.self).first {
            simpleTextSnackBar(title: "success_check".localized(using: "Localizable"))
            findedBasket.deleteAllFromBasket()
        }
    }
}

extension CheckoutViewController: CheckoutWithIDViewModelProtocol {
    func checkoutWithId() {
        if let findedBasket = uiRealm.objects(BasketModel.self).first {
            simpleTextSnackBar(title: "success_check".localized(using: "Localizable"))
            findedBasket.deleteAllFromBasket()
        }
    }
}

extension CheckoutViewController : AddressViewControllerDelegate {
    func didRecieveAddress(nameAddress: String, addressID: Int, address: String, district: String, city: String) {
        checkOutID = addressID
        
        _view.savedView.savedLabel.text = nameAddress
        _view.fillView.addressTextField.text = address
        _view.fillView.districtTextField.text = district
        _view.fillView.cityTextField.text = city
        
        _view.fillView.addressTextField.isEnabled = false
        _view.fillView.districtTextField.isEnabled = false
        _view.fillView.cityTextField.isEnabled = false
        _view.fillView.mapButton.isEnabled = false
    }
}
