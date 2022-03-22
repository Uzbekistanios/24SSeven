import UIKit

class NYViewController: UIViewController {
    
    override open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        guard let root = self.view.window?.rootViewController else {return}
        
        if let vc = root.presentedViewController {
            presentIn(vc, viewControllerToPresent: viewControllerToPresent, animated: flag, completion: completion)
        } else {
            root.present(viewControllerToPresent, animated: flag, completion: completion)
        }
    }
    
    private func presentIn(_ presentedViewController: UIViewController, viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        
        if let vc = presentedViewController.presentedViewController {
            presentIn(vc, viewControllerToPresent: viewControllerToPresent, animated: flag, completion: completion)
        } else {
            presentedViewController.present(viewControllerToPresent, animated: flag, completion: completion)
        }
    }
}

