//
//  GenericFilterViewController.swift
//  24SEVEN
//
//  Created by Islom on 26/02/21.
//

import UIKit
import SideMenu

class GenericFilterViewController : UIViewController {
    
    let genericFilterView = GenericFilterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func loadView() {
        view = genericFilterView
    }
}

extension GenericFilterViewController {
    private func setup() {
        if let genericFilterView = view as? GenericFilterView {
            if let navVc = self.navigationController as? SideMenuNavigationController {
                if navVc.viewControllers.count < 2 {
                    genericFilterView.navBarView.backButton.isHidden = true
                }
                setupTargets()
            }
        }
    }
    
    private func setupTargets() {
        if let genericFilterView = view as? GenericFilterView {
            genericFilterView.navBarView.backButton.addTarget(self, action: #selector(popVC), for: .primaryActionTriggered)
            genericFilterView.navBarView.doneButton.addTarget(self, action: #selector(applyFilter), for: .primaryActionTriggered)
            genericFilterView.clearButton.addTarget(self, action: #selector(clearFilters), for: .primaryActionTriggered)
        }
    }
    
    func pushViewController(_ vc: UIViewController, animated: Bool) {
        if let navVc = self.navigationController as? SideMenuNavigationController {
            navVc.pushStyle = .subMenu
            navVc.pushViewController(vc, animated: animated)
        }
    }
    
    @objc func popVC() {
        if let navVC = self.navigationController as? SideMenuNavigationController {
            navVC.popViewController(animated: true)
        }
    }
    
    @objc func applyFilter() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func clearFilters() {
        
    }
    
}
