
import UIKit

class SubcategoryViewController : GenericViewController {
    
    let subcategoryView = SubcategoryView()

    var currentSubModel: CategoryModelElement? {
        didSet {
            subcategoryView.navBarView.title = currentSubModel?.name
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func loadView() {
        super.loadView()
        view = subcategoryView
    }
}


extension SubcategoryViewController {
    private func setupTableView() {
        subcategoryView.tableView.delegate = self
        subcategoryView.tableView.dataSource = self
    }
}

extension SubcategoryViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  currentSubModel?.parents?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SubcategoryTableViewCell.reuseId, for: indexPath) as? SubcategoryTableViewCell else { return UITableViewCell()}
        
        cell.subcategoryLabel.text = currentSubModel?.parents?[indexPath.row].name
        cell.numberOfItemsView.numberOfItemsLabel.text = currentSubModel?.parents?[indexPath.row].productsCount?.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
}

extension SubcategoryViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let model = currentSubModel {
            
            if model.parents?[indexPath.row].parents?.count == 0 {
                let subcategoryVC = ViewAllViewController()
                subcategoryVC.categoryId = model.parents?[indexPath.row].id
                subcategoryVC.navBarTitle = model.parents?[indexPath.row].name
                navigationController?.pushViewController(subcategoryVC, animated: true)
            } else {
                let subcategoryVC = SubcategoryViewController()
                subcategoryVC.currentSubModel = model.parents?[indexPath.row]
                navigationController?.pushViewController(subcategoryVC, animated: true)
            }
        }
    }
}
