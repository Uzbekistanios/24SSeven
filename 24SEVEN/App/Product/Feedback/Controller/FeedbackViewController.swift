
import UIKit
import SideMenu

class FeedbackViewController : UIViewController {
    
    let _view = FeedbackView()
    
    var productId: Int = 1
    let addCommentViewModel = FeedbackViewModel()
    
    var numberOfComments: Int?
    
    var feedBackViewModel : [CategoryComment]? {
        didSet {
            numberOfComments = feedBackViewModel?.count
            _view.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bottomSheet()
    }
    
    override func loadView() {
        super.loadView()
        view = _view
    }
}

extension FeedbackViewController {
    private func setupTableView() {
        _view.tableView.delegate = self
        _view.tableView.dataSource = self
    }
    
    private func bottomSheet() {
        _view.handleFeedback = { [weak self] in
            guard let self = self else { return }
            if AuthManager.shared.isAuthenticated() {
                let feedVC = FeedBackAddCommentController()
                feedVC.modalPresentationStyle = .custom
                feedVC.transitioningDelegate = self
                feedVC.delegate = self
                self.present(feedVC, animated: true)
            } else {
                self.snackBarForLogin()
            }
        }
    }
}


extension FeedbackViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfComments ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedbackTableViewCell.reuseId, for: indexPath) as? FeedbackTableViewCell else {return UITableViewCell()}
        cell.cellModel = feedBackViewModel?[indexPath.row]
        return cell
    }
    
}

//MARK: - UIViewControllerTransitioningDelegate
extension FeedbackViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

//MARK: - SortViewControllerDelegate
extension FeedbackViewController : FeedBackAddCommentDelegate {
    func didSelectFeedBack(option: String) {
        addCommentViewModel.delegate = self
        addCommentViewModel.addComment(productId: productId, firstName: UserPreferences.shared.userName ?? "", body: option)
    }
}

//MARK: - SideMenuNavigationControllerDelegate
extension FeedbackViewController: SideMenuNavigationControllerDelegate, UINavigationControllerDelegate {
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        
        UIView.animate(withDuration: menu.presentDuration) {
            self.view.alpha = 0.4
            self.tabBarController?.tabBar.alpha = 0.4
        }
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        UIView.animate(withDuration: menu.dismissDuration) {
            self.view.alpha = 1
            self.tabBarController?.tabBar.alpha = 1
        }
    }
}

extension FeedbackViewController : FeedbackViewModelProtocol {
    func addComment() {
        simpleTextSnackBar(title: "in_review".localized(using: "Localizable"))
    }
}
