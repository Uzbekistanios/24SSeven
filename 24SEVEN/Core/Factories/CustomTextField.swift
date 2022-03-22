//
//  UITextField.swift
//  24SEVEN
//
//  Created by Islom on 02/02/21.
//

import UIKit

class CustomTextField: UITextField {

    var padding = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
