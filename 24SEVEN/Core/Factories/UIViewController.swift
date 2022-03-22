//
//  UIViewController.swift
//  24SEVEN
//
//  Created by Islom on 10/02/21.
//

import UIKit

extension UIViewController {
    func addToNav(vc: UIViewController) {
        if let rootVC = self.navigationController?.viewControllers.last {
            vc.view.frame = rootVC.view.frame
            rootVC.view.addSubview(vc.view)
            rootVC.addChild(vc)
            vc.willMove(toParent: rootVC)
            vc.didMove(toParent: rootVC)
        }
    }
}
