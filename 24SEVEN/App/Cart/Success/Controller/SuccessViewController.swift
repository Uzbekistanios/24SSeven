//
//  SuccessViewController.swift
//  24SEVEN
//
//  Created by Islom on 12/02/21.
//

import UIKit

class SuccessViewController : GenericViewController {
    
    let _view = SuccessView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTargets()
    }
    
    override func loadView() {
        super.loadView()
        view = _view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
}

extension SuccessViewController {
    private func setupTargets() {
        
        _view.targetButton.targetClosure = { [weak self] in
            guard let self = self else {return}
            
            self.tabBarController?.selectedIndex = 0
            self.navigationController?.popToRootViewController(animated: false)
        
        }
    }
}
