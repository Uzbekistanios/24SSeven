//
//  PaymentOptionsViewController.swift
//  24SEVEN
//
//  Created by Islom on 17/02/21.
//

import UIKit

class PaymentOptionsViewController : HideBottomBarViewController {
    
    let paymentOptions : [PaymentOptions] = [
        .transfer,
        .cash
    ]
    
    let _view = PaymentOptionsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    override func loadView() {
        view = _view
    }
}

extension PaymentOptionsViewController {
    private func setupTableView() {
        _view.tableView.delegate = self
        _view.tableView.dataSource = self
    }
}

//MARK: - UITableViewDataSource
extension PaymentOptionsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PaymentOptionsTableViewCell.reuseId, for: indexPath) as? PaymentOptionsTableViewCell else { return UITableViewCell()}
        cell.option = paymentOptions[indexPath.row]
        return cell
    }
}

//MARK: - UITableViewDelegate
extension PaymentOptionsViewController : UITableViewDelegate {
    
}
