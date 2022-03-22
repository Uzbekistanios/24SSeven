
import UIKit
import RealmSwift

class CartViewController : GenericViewController {
    
    let _view = CartView()
    var itemsCount: Int?
    var paramSentMain = [String:String]()
    
    internal var basketList: Results<BasketModel>! {
        didSet { itemsCount = basketList.count }
    }
    var cartViewModel = CartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        targetButtonAction()
    }
    
    override func loadView() {
        view = _view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBasketCardList()
        _view.tableView.refreshControl = UIRefreshControl()
        _view.tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc func refresh(){
        getBasketCardList()
        DispatchQueue.main.async {
            self._view.tableView.refreshControl?.endRefreshing()
        }
    }
}

extension CartViewController  {
    private func setupTableView() {
        _view.tableView.delegate = self
        _view.tableView.dataSource = self
    }
    
    private func targetButtonAction() {
        _view.checkoutButton.targetClosure = { [weak self] in
            guard let self = self else { return }
            let vc = CheckoutViewController()
            
            vc.params = self.paramSentMain
            vc.priceInitial = self.cartViewModel.itemsCard?.total ?? 0
            vc.priceDelivery = self.cartViewModel.itemsCard?.deliveryPrice ?? 0
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func getBasketCardList() {
        var params = [String:String]()
        
        basketList = uiRealm.objects(BasketModel.self)
        
        if let tabItems = tabBarController?.tabBar.items {
            let tabItem = tabItems[2]
            if basketList.count > 0 {
                tabItem.badgeValue = "\(basketList.count)"
                tabItem.badgeColor = UIColor.defaultOrange
            } else if basketList.count == 0 {
                tabItem.badgeValue = ""
                tabItem.badgeColor = UIColor.clear
            }
        }
        
        if basketList.count != 0 {
            for i in 0 ..< basketList.count {
                params["products[\(i)][id]"] = basketList[i].id.description
                params["products[\(i)][count]"] = basketList[i].count.description
            }
        }
        
        paramSentMain = params
        
        if basketList.count != 0 {
            _view.checkoutButton.targetButton.isEnabled = true
            _view.checkoutButton.targetButton.backgroundColor = .mainButtonBackgrounColor
            self.cartViewModel.getCardInfo(param: params)
        } else {
            _view.checkoutButton.targetButton.isEnabled = false
            _view.checkoutButton.targetButton.backgroundColor = .mainButtonBackgrounColor?.withAlphaComponent(0.7)
            self.cartViewModel.getCardInfo(param: [:])
        }
        
        self.cartViewModel.delegate = self
    }
}


extension CartViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartItemTableViewCell.reuseId, for: indexPath) as? CartItemTableViewCell else { return UITableViewCell()}
        
        var numberOfItems = 1.0
        let multiplication = cartViewModel.itemsCard?.products?[indexPath.row].unit?.count ?? 0.0
        let unitName = cartViewModel.itemsCard?.products?[indexPath.row].unit?.name ?? ""
        
        for item in uiRealm.objects(BasketModel.self).filter("id == \(cartViewModel.itemsCard?.products?[indexPath.row].id ?? 0)") {
            numberOfItems = Double(item.count)
        }
        
        if numberOfItems <= 1 {
            cell.item.selectorView.decrementButton.isEnabled = false
        } else {
            cell.item.selectorView.decrementButton.isEnabled = true
        }
        
        cell.item.itemImageView.setImage(imageUrl: cartViewModel.itemsCard?.products?[indexPath.row].image?.pathThumb ?? "")
        cell.item.titleLabel.text = cartViewModel.itemsCard?.products?[indexPath.row].name
        cell.item.priceLabel.text = "\(cartViewModel.itemsCard?.products?[indexPath.row].price?.description ?? "")" + "money_format_sum_unit".localized(using: "Localizable") + "\(cartViewModel.itemsCard?.products?[indexPath.row].unit?.name ?? "")"
        cell.item.selectorView.quantityLabel.text = "\(numberOfItems * multiplication) \(unitName)"
        
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, complete in
            
            if let findedBasket = uiRealm.objects(BasketModel.self).filter({
                $0.id == self.cartViewModel.itemsCard?.products?[indexPath.row].id ?? 0
            }).first {
                findedBasket.deleteFromRealm()
            }
            
            self.getBasketCardList()
            complete(true)
        }
        
        deleteAction.image = UIImage(named: "bin")
        deleteAction.backgroundColor = .mainBackgroundColor
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        
        return configuration
    }
}

extension CartViewController : CartItemTableViewCellProtocol {
    func removeItem(cell: CartItemTableViewCell) {
        guard let indexPath = self._view.tableView.indexPath(for: cell) else { return }
        
        if let findedBasket = uiRealm.objects(BasketModel.self).filter({
            $0.id == self.cartViewModel.itemsCard?.products?[indexPath.row].id ?? 0
        }).first {
            findedBasket.deleteFromRealm()
        }
        
        getBasketCardList()
    }
    
    func didChangeItemCount(cell: CartItemTableViewCell, sender: UIButton) {
        guard let indexPath = self._view.tableView.indexPath(for: cell) else { return }
        let basket = BasketModel()
        
        switch sender.tag {
        case 2: basket.count = 1
        case 1: basket.count = -1
        default: return
        }
        
        if let findedBasket = uiRealm.objects(BasketModel.self).filter({
            $0.id == self.cartViewModel.itemsCard?.products?[indexPath.row].id ?? 0
        }).first {
            basket.id = cartViewModel.itemsCard?.products?[indexPath.row].id ?? 0
            basket.count += findedBasket.count
            findedBasket.deleteFromRealm()
            basket.writeToRealm()
            getBasketCardList()
        }
    }
}

extension CartViewController : CartViewModelProtocol {
    func didUpdateCheckoutPage() {
        _view.priceLabel.text = "\(cartViewModel.itemsCard?.total?.description ?? "")" + "money_format_sum".localized(using: "Localizable")
        _view.tableView.reloadData()
    }
}
