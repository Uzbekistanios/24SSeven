//
//  UILabels.swift
//  24SEVEN
//
//  Created by Khushnidjon Keldiboev on 12/01/21.
//

import UIKit

extension UILabel {
    static func makeLabel(string: String = "Default", size: UIFont.AppFontSize = .l, weight: UIFont.GolosWeight = .medium, alignment: NSTextAlignment = .center) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = string
        label.font = .appFont(size: size, weight: weight)
        label.textAlignment = alignment
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.7
        return label
    }
}
