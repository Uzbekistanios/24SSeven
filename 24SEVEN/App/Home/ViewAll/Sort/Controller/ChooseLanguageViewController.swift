

import UIKit

protocol ChooseLanguageViewControllerDelegate {
    func didSelectSortOption(option: String, index: Int)
}

class ChooseLanguageViewController : BottomSheetViewController {
 
    let _view = SortView()
    
    var delegate: ChooseLanguageViewControllerDelegate?
    
    let languageOptions: [String] = [
        "Uzbek",
        "Russian",
    ]
    
    override func loadView() {
        view = _view
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        _view.pan.title = "Выберите язык"
    }
    
    private func setupTableView() {
        _view.tableView.delegate = self
        _view.tableView.dataSource = self
    }
}

//MARK: - UITableViewDataSource
extension ChooseLanguageViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SortOptionsTableViewCell.reuseId, for: indexPath) as? SortOptionsTableViewCell else { return UITableViewCell() }
        cell.title = languageOptions[indexPath.row]
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ChooseLanguageViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SortOptionsTableViewCell else { return }
        cell.selectedState()
        
        self.delegate?.didSelectSortOption(option: self.languageOptions[indexPath.row], index: indexPath.row)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { //imitate network request
            self.dismiss(animated: true, completion: nil)
        }
    }
}
