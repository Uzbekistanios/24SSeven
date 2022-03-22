//
//  DescriptionViewController.swift
//  24SEVEN
//
//  Created by Islom on 11/02/21.
//

import UIKit
import RealmSwift

class DescriptionViewController : UIViewController {
    
    var productId: Int?
    var itemCountStatic = 1.0
    
    var productViewModel : CategoryProductItem? {
        didSet {
            _view.viewModel = productViewModel
            productId = productViewModel?.id ?? 0
            addToBasket()
        }
    }
    
    let _view = DescriptionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        valueChange()
    }
    
    override func loadView() {
        super.loadView()
        view = _view
    }
    
    private func valueChange() {
        _view.quantity.selectorView.incrementHandler = { [weak self] in
            guard let self = self else { return }
            self.itemCountStatic += 1
            self._view.quantity.selectorView.quantityLabel.text = "\(Double(self.productViewModel?.unit?.count ?? 1.0) * self.itemCountStatic) \(self.productViewModel?.unit?.name ?? "")"
        }
        _view.quantity.selectorView.decrementHandler = { [weak self] in
            guard let self = self else { return }
            if self.itemCountStatic > 1 {
                self.itemCountStatic -= 1
                self._view.quantity.selectorView.quantityLabel.text = "\(Double(self.productViewModel?.unit?.count ?? 1.0) * self.itemCountStatic) \(self.productViewModel?.unit?.name ?? "")"
            }
        }
    }
    
    private func addToBasket() {
        _view.cartHandler = { [weak self] in
            guard let self = self else { return }
            
            let basket = BasketModel()
            basket.id = self.productViewModel?.id ?? 0
            basket.count = Int(self.itemCountStatic)
            
            if let findedBasket = uiRealm.objects(BasketModel.self).filter({
                $0.id == self.productId
            }).first {
                basket.count += findedBasket.count
                findedBasket.deleteFromRealm()
            }
            self.itemCountStatic = 1
            self.simpleTextSnackBar(title: "added_to_basket".localized(using: "Localizable"))
            basket.writeToRealm()
        }
    }
}
