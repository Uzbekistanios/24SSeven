//
//  CategoryViewController.swift
//  24SEVEN
//
//  Created by Islom on 08/02/21.
//

import UIKit


class CategoryViewController : GenericViewController{
    
    let categoryView = CategoryView()
    
    private let viewModel = CategoryViewModel()
    
    var numberOfCategories: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        super.loadView()
        view = categoryView
    }
}

extension CategoryViewController {
    private func setup() {
        categoryView.tableView.delegate = self
        categoryView.tableView.dataSource = self
        
        viewModel.delegate = self
        viewModel.fetchHomePage()
    }
}

extension CategoryViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCategories ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseId, for: indexPath) as? CategoryTableViewCell else { return UITableViewCell()}
        cell.categoryImageView.setImage(imageUrl: viewModel.categories?[indexPath.row].image ?? "")
        cell.categoryLabel.text = viewModel.categories?[indexPath.row].name
       return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116.0
    }
}

extension CategoryViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subcategoryVC = SubcategoryViewController()
        subcategoryVC.currentSubModel = viewModel.categories?[indexPath.row]
        subcategoryVC.subcategoryView.navBarView.title = viewModel.categories?[indexPath.row].name
        navigationController?.pushViewController(subcategoryVC, animated: true)
    }
}


extension CategoryViewController: CategoryViewModelProtocol {
    func didUpdateCategoryPage() {
        numberOfCategories = viewModel.categories?.count
        categoryView.tableView.reloadData()
    }
}
