//
//  FilterDetailsViewController.swift
//  24SEVEN
//
//  Created by Islom on 26/02/21.
//

import UIKit

class FilterDetailsViewController : GenericFilterViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupTableView()
    }
}

extension FilterDetailsViewController  {
    private func setupTableView() {
        genericFilterView.tableView.delegate = self
        genericFilterView.tableView.dataSource = self
    }
}

//MARK: - UITableViewDataSource
extension FilterDetailsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterDetailsTableViewCell.reuseId, for: indexPath) as? FilterDetailsTableViewCell else { return UITableViewCell() }
        cell.checked = false
        
        cell.selectClosure = { [weak self] in
            guard let self = self else { return }
            cell.checked = !cell.checked!
        }
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension FilterDetailsViewController : UITableViewDelegate {
    
}
