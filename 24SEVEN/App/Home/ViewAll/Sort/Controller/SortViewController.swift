//
//  SortViewController.swift
//  24SEVEN
//
//  Created by Islom on 04/02/21.
//

import UIKit

protocol SortViewControllerDelegate {
    func didSelectSortOption(option: String, index: Int)
}

class SortViewController : BottomSheetViewController {
 
    let _view = SortView()
    
    var delegate: SortViewControllerDelegate?
    
    let sortOptions: [String] = [
        "sort_by_new".localized(using: "Localizable"),
        "sort_by_popular".localized(using: "Localizable"),
        "sort_by_cheap".localized(using: "Localizable"),
        "sort_by_expensive".localized(using: "Localizable"),
    ]
    
    override func loadView() {
        view = _view
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    private func setupTableView() {
        _view.tableView.delegate = self
        _view.tableView.dataSource = self
    }
}

//MARK: - UITableViewDataSource
extension SortViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SortOptionsTableViewCell.reuseId, for: indexPath) as? SortOptionsTableViewCell else { return UITableViewCell() }
        cell.title = sortOptions[indexPath.row]
        return cell
    }
}

//MARK: - UITableViewDelegate
extension SortViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SortOptionsTableViewCell else { return }
        cell.selectedState()
        
        self.delegate?.didSelectSortOption(option: self.sortOptions[indexPath.row], index: indexPath.row)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { //imitate network request
            self.dismiss(animated: true, completion: nil)
        }
    }
}
