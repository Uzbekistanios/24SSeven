//
//  OrderDetailsViewController.swift
//  24SEVEN
//
//  Created by Islom on 15/02/21.
//

import UIKit
enum OrderSections : Int{
    case info
    case items
}

class OrderDetailsViewController : HideBottomBarViewController {
   
    let _view = OrderDetailsView()
    let viewModel = OrderDetailViewModel()
    let viewModelDelete = DeleteOrderViewModel()
    var orderID: Int = 0
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVM()
        setupTableView()
        setupDeleteButton()
    }
    
    override func loadView() {
        view = _view
    }
}

extension OrderDetailsViewController {
    
    private func setupDeleteButton() {
        _view.targetView.targetClosure = { [weak self] in
            guard let self = self else { return }
            self.viewModelDelete.delegate = self
            self.viewModelDelete.cancelOrder(orderID: self.orderID)
        }
    }
    
    private func setupTargetButtonState() {
        if viewModel.orderItem?.status == "cancelled" {
            //button must get disabled
            _view.targetView.targetButton.isEnabled = false
            _view.targetView.targetButton.backgroundColor = UIColor.defaultRed.withAlphaComponent(0.3)
            _view.targetView.targetButton.isUserInteractionEnabled = false
        } else if viewModel.orderItem?.status == "closed" {
            //buttton must hide
            _view.targetView.targetButton.isHidden = true
        } else {
            _view.targetView.targetButton.backgroundColor = UIColor.defaultRed.withAlphaComponent(1)
        }
    }
    
    private func setupTableView() {
        _view.tableView.delegate = self
        _view.tableView.dataSource = self
    }
    
    private func setupVM() {
        viewModel.delegate = self
        viewModel.getOrderDetail(orderID: orderID)
    }
}

extension OrderDetailsViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch OrderSections(rawValue: section) {
        case .info:
            return 1
        case .items:
            return viewModel.orderProducts?.count ?? 0
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch OrderSections(rawValue: indexPath.section) {
        case .info:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderInfoTableViewCell.reuseId, for: indexPath) as? OrderInfoTableViewCell else { return UITableViewCell()}
            
            let overallPrice = (viewModel.orderItem?.priceProducts ?? 0) + (viewModel.orderItem?.priceDelivery ?? 0)
            
            cell.orderNumLabel.text = "Заказ №".localized(using: "Localizable") + "\(viewModel.orderItem?.id?.description ?? "")"
            cell.statusLabel.text = viewModel.orderItem?.status
            cell.labelsView.dateLabel.text = viewModel.orderItem?.createdAt
            cell.labelsView.quantityLabel.text = "\(viewModel.orderItem?.productsCount ?? 0) товара"
            cell.labelsView.addressLabel.text = viewModel.orderItem?.address?.address
            cell.labelsView.paymentLabel.text = viewModel.orderItem?.paymentType
            cell.labelsView.totalLabel.text = "\(overallPrice.description) " + "money_format_sum".localized(using: "Localizable")

            return cell
        case .items:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailTableViewCell.reuseId, for: indexPath) as? OrderDetailTableViewCell else { return UITableViewCell() }
            
            cell.item.itemImageView.setImage(imageUrl: viewModel.orderProducts?[indexPath.row].image?.pathThumb ?? "")
            cell.item.titleLabel.text = viewModel.orderProducts?[indexPath.row].name
            cell.item.quantityLabel.text = "order_item_count".localized(using: "Localizable") + "\(viewModel.orderProducts?[indexPath.row].unit?.count ?? 0)\(viewModel.orderProducts?[indexPath.row].unit?.name ?? "")"
            cell.item.priceLabel.text = "\(viewModel.orderProducts?[indexPath.row].price ?? "") " + "money_format_sum".localized(using: "Localizable")
            return cell
        case .none:
            return UITableViewCell()
        }
    }
}


extension OrderDetailsViewController : UITableViewDelegate {

}

extension OrderDetailsViewController : OrderDetailViewModelProtocol {
    func getOrderDetailItem() {
        _view.tableView.reloadData()
        setupTargetButtonState()
    }
}

extension OrderDetailsViewController : DeleteOrderViewModelProtocol {
    func cancelOrder() {
        simpleTextSnackBar(title: "declined_order".localized(using: "Localizable"))
        navigationController?.popViewControllers(viewsToPop: 2)
    }
}
