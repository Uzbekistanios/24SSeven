//
//  ReuseableCells.swift
//  24SEVEN
//
//  Created by Islom on 02/02/21.
//

import UIKit

extension UIView {
    static var reuseId : String {
        return String(describing: self)
    }
}
