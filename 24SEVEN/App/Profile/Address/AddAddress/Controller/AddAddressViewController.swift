//
//  AddAddressViewController.swift
//  24SEVEN
//
//  Created by Islom on 17/02/21.
//

import UIKit

class AddAddressViewController : HideBottomBarViewController {
    
    let _view = AddAddressView()
    let viewModelAdd = AddAdressViewModel()
    let viewmodelGetItem = GetAddressViewModel()
    let viewModelDelete = DeleteAddressViewModel()
    let viewModelUpdate = EditAddressViewModel()
    var currentIDEdit : Int = 0
    
    var lat: String = "0.0"
    var long: String = "0.0"
    
    init(mode: AddAddressMode) {
        _view.mode = mode
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargets()
        
        if _view.mode == .edit {
            setupViewModelEdit()
            setupDeleteAddress()
        }
    }
    
    override func loadView() {
        view = _view
    }
}

extension AddAddressViewController {
    private func setupTargets() {
        saveAddress()
        pinOnMap()
    }
    
    private func setupViewModelEdit() {
        viewmodelGetItem.delegate = self
        viewmodelGetItem.getAddress(addressID: currentIDEdit)
    }
    
    private func setupDeleteAddress() {
        _view.addressTextFields.deleteClosure = { [weak self] in
            guard let self = self else { return }
            self.viewModelDelete.delegate = self
            self.viewModelDelete.getAddress(addressID: self.currentIDEdit)
        }
    }
    
    private func saveAddress() {
        
        _view.targetView.targetClosure = { [weak self] in
            guard let self = self else { return }
            if self._view.addressTextFields.addressTextField.text?.count == 0 ||
                self._view.addressTextFields.districtTextField.text?.count == 0 ||
                self._view.addressTextFields.cityTextField.text?.count == 0 ||
                self._view.addressTextFields.titleTextField.text?.count == 0 {
                self.simpleTextSnackBar(title: "no_empty".localized(using: "Localizable"))
            } else {
                
                guard let userPhone = UserPreferences.shared.userPhone else { return }
                
                if self._view.mode == .add {
                    self.viewModelAdd.delegate = self
                    self.viewModelAdd.addAddress(name: self._view.addressTextFields.titleTextField.text ?? "", address: self._view.addressTextFields.addressTextField.text ?? "", city: self._view.addressTextFields.cityTextField.text ?? "", region: self._view.addressTextFields.districtTextField.text ?? "", locationLat: self.lat, locationLang: self.long, phone: userPhone)
                } else {
                    self.viewModelUpdate.delegate = self
                    self.viewModelUpdate.updateAddress(addressId: self.currentIDEdit, name: self._view.addressTextFields.titleTextField.text ?? "", address: self._view.addressTextFields.addressTextField.text ?? "", city: self._view.addressTextFields.cityTextField.text ?? "", region: self._view.addressTextFields.districtTextField.text ?? "", locationLat: self.lat, locationLang: self.long, phone: userPhone)
                }
            }
        }
    }
    
    private func pinOnMap() {
        _view.addressTextFields.pinMapClosure = { [weak self] in
            guard let self = self else { return }
            let navVC = YandexMapController()
            navVC.delegate = self
            self.navigationController?.pushViewController(navVC, animated: true)
        }
    }
}

extension AddAddressViewController: YandexMapViewControllerDelegate {
    func didChanged(lat: String, long: String, adress: String, district: String, city: String) {
        _view.addressTextFields.addressTextField.text = adress
        _view.addressTextFields.districtTextField.text = district
        _view.addressTextFields.cityTextField.text = city
        self.lat = lat
        self.long = long
    }
}

extension AddAddressViewController : EditAddressViewModelProtocol {
    func editAddress() {
        simpleTextSnackBar(title: "loaded_success".localized(using: "Localizable"))
        navigationController?.popViewControllers(viewsToPop: 2)
    }
}

extension AddAddressViewController : AddAdressViewModelProtocol {
    func addedAddress() {
        simpleTextSnackBar(title: "added_success".localized(using: "Localizable"))
        navigationController?.popViewControllers(viewsToPop: 2)
    }
}

extension AddAddressViewController : GetAddressViewModelProtocol {
    func getAddress() {
        _view.addressTextFields.titleTextField.text = viewmodelGetItem.item?.name
        _view.addressTextFields.addressTextField.text = viewmodelGetItem.item?.address
        _view.addressTextFields.districtTextField.text = viewmodelGetItem.item?.region
        _view.addressTextFields.cityTextField.text = viewmodelGetItem.item?.city
        lat = viewmodelGetItem.item?.location?.lat ?? "0.0"
        long = viewmodelGetItem.item?.location?.lng ?? "0.0"
    }
}

extension AddAddressViewController : DeleteAddressViewModelProtocol {
    func deleteAddress() {
        navigationController?.popViewControllers(viewsToPop: 2)
    }
}
