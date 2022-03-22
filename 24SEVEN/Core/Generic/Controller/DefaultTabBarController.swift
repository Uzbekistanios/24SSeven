
import UIKit
import RealmSwift

class DefaultTabBarController: UITabBarController {
    
    let homeVC: UIViewController = makeTabVC(vc: HomeViewController(), image: UIImage(named: Constants.homeTab))
    let categoryVC: UIViewController = makeTabVC(vc: CategoryViewController(), image: UIImage(named: Constants.categoryTab))
    let cartVC: UIViewController = makeTabVC(vc: CartViewController(), image: UIImage(named: Constants.cartTab))
    let profileVC: UIViewController = makeTabVC(vc: ProfileViewController(), image: UIImage(named: Constants.userProfileTab))
    
    internal var basketList: Results<BasketModel>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTabs()
        setupBadgeCount()
    }
    
    private func setupTabs(){
        self.delegate = self
        tabBar.barTintColor = UIColor.black //UIColor.tabBarPrimaryColor
        tabBar.tintColor =  UIColor.black//UIColor.tabBarItemsPrimaryColor
        viewControllers = [homeVC, categoryVC, cartVC, profileVC]
    }
}


extension DefaultTabBarController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 3 {
            if AuthManager.shared.isAuthenticated() == false {
                let vc = LoginViewController()
                vc.dissmissHidden = false
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
            }
        }
    }
}

extension DefaultTabBarController {
    func setupBadgeCount() {
        if uiRealm.objects(BasketModel.self).count > 0 {
            cartVC.tabBarItem.badgeValue = "\(uiRealm.objects(BasketModel.self).count)"
            cartVC.tabBarItem.badgeColor = UIColor.defaultOrange
        }
    }
}

fileprivate func makeTabVC(vc: UIViewController, title: String? = nil, image: UIImage? = nil, selectedImage: UIImage? = nil) -> UIViewController {
    let tab = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
    tab.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
    let nc = UINavigationController(rootViewController: vc)
    nc.navigationBar.isHidden = true
    nc.tabBarItem = tab
    return nc
}

