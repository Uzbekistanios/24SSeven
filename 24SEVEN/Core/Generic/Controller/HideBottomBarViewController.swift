//
//   HideBottomBarViewController.swift
//  24SEVEN
//
//  Created by Islom on 20/02/21.
//

import UIKit

class HideBottomBarViewController : GenericViewController {
    override init() {
        super.init()
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
