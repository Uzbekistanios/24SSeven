
import UIKit
import Moya
import BarcodeScanner
import SafariServices

class GenericViewController: UIViewController{
    
    let genericView = GenericView()
    var provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        view = genericView
    }
}

extension GenericViewController {
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let genericView = view as? GenericView {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                UIView.animate(withDuration: 0.2) {
                    let height: CGFloat = (self.tabBarController?.tabBar.isHidden ?? true) ? 0 : self.tabBarController?.tabBar.frame.height ?? 0
                    genericView.contentViewBottom.constant = -(keyboardSize.height - height)
                    genericView.setNeedsUpdateConstraints()
                    genericView.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let genericView = view as? GenericView {
            UIView.animate(withDuration: 0.2) {
                genericView.contentViewBottom.constant = 0
                genericView.setNeedsUpdateConstraints()
                genericView.layoutIfNeeded()
            }
        }
    }
    
    func setupObservers() {
        if let genericView = view as? GenericView {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tap.cancelsTouchesInView = false
            genericView.addGestureRecognizer(tap)
        }
    }
    
    private func setup() {
        if let genericView = view as? GenericView {
            genericView.navBarView.backButton.addTarget(self, action: #selector(popVC), for: .primaryActionTriggered)
            setupObservers()
            showFavorites()
            showScan()
            search()
            if navigationController?.viewControllers.count ?? 1 > 1 {
                genericView.navBarView.logoImageView.isHidden = true
            } else {
                genericView.navBarView.titleLabel.isHidden = true
                genericView.navBarView.backButton.isHidden = true
            }
        }
    }
    
    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    func showFavorites() {
        if let genericView = view as? GenericView {
            genericView.searchVC.searchAndScanView.favoriteClosure = { [weak self] in
                guard let self = self else { return }
                if AuthManager.shared.isAuthenticated() {
                    self.navigationController?.pushViewController(ViewGroupViewController(type: .favorites), animated: true)
                } else {
                    self.snackBarForLogin()
                }
            }
        }
    }
    
    func showScan() {
        if let genericView = view as? GenericView {
            genericView.searchVC.searchAndScanView.scanClosure = { [weak self] in
                guard let self = self else { return }
                
                let viewController = BarcodeScannerViewController()
                viewController.headerViewController.titleLabel.text = "Сканер QR-кода"
                viewController.headerViewController.titleLabel.textColor = UIColor.mainTextColor
                viewController.headerViewController.closeButton.tintColor = UIColor.defaultOrange
                viewController.messageViewController.errorTintColor = UIColor.defaultOrange
                
                viewController.codeDelegate = self
                viewController.errorDelegate = self
                viewController.dismissalDelegate = self
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }
    
    func search() {
        if let genericView = view as? GenericView {
            genericView.searchVC.searchAndScanView.searchClosure = { [weak self] in
                guard let self = self else { return }
                if self.navigationController?.viewControllers.count ?? 0 <= 1  {
                    self.navigationController?.pushViewController(SearchResultViewController(), animated: false)
                }
            }
        }
    }
}

extension GenericViewController : BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        simpleTextSnackBar(title: "qr_added".localized(using: "Localizable"))
        
        let pasteboard = UIPasteboard.general
        pasteboard.string = code
        
        controller.reset()
        controller.dismiss(animated: true, completion: nil)
        
        if verifyUrl(urlString: code) {
            guard let url = URL(string: code) else {return}
            let safariVc = SFSafariViewController(url: url)
            self.present(safariVc, animated: true, completion: nil)
        } else {
            simpleTextSnackBar(title: "wrong_url".localized(using: "Localizable"))
        }
    }
    
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        simpleTextSnackBar(title: error.localizedDescription)
    }
    
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension GenericViewController {
    func addChildToScroll(vc: UIViewController) {
        addChild(vc)
        if let genericScrollView = view as? GenericScrollView {
            genericScrollView.scrollContent.addSubview(vc.view)
        }
        vc.didMove(toParent: self)
    }
    
    func addChildViewController(vc: UIViewController, embedView: Bool = true) {
        vc.willMove(toParent: self)
        addChild(vc)
        if let genericView = view as? GenericView, embedView {
            genericView.contentView.addSubview(vc.view)
        }
        vc.didMove(toParent: self)
    }
}
