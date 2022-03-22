//
//  NYView.swift
//  24SEVEN
//
//  Created by Islom on 21/01/21.
//

import UIKit

class IBView: UIView {
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.mainBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(cod@objc er:) has not been implemented")
    }
}
