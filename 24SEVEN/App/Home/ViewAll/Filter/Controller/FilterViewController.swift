//
//  FilterViewController.swift
//  24SEVEN
//
//  Created by Islom on 25/02/21.
//

import UIKit

class FilterViewController : GenericFilterViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
}

extension FilterViewController {
    private func setupTableView() {
        genericFilterView.tableView.delegate = self
        genericFilterView.tableView.dataSource = self
    }
}

//MARK: - UITableViewDataSource
extension FilterViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.reuseId, for: indexPath) as? FilterTableViewCell else { return UITableViewCell()}
        return cell
    }
}

//MARK: - UITableViewDelegate
extension FilterViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushViewController(FilterDetailsViewController(), animated: true)
    }
}
