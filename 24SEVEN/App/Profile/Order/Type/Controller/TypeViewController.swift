//
//  TypeViewController.swift
//  24SEVEN
//
//  Created by Islom on 13/02/21.
//

import UIKit

class TypeViewController : UIViewController {
    
    var type: OrderTypes
    
    let _view = TypeView()
    
    init(type: OrderTypes) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    override func loadView() {
        view = _view
    }
}

extension TypeViewController {
    private func setupTableView() {
        _view.tableView.delegate = self
        _view.tableView.dataSource = self
    }
}

extension TypeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderTypeTableViewCell.reuseId, for: indexPath) as? OrderTypeTableViewCell else { return UITableViewCell()}
        cell.type = self.type
        cell.inspectClosure = { [weak self]  in
            guard let self = self else { return }
            let detailsVC = OrderDetailsViewController()
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
        return cell
    }
}

extension TypeViewController : UITableViewDelegate {
    
}
