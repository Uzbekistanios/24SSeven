//
//  OrderTypes.swift
//  24SEVEN
//
//  Created by Islom on 17/02/21.
//

import UIKit

enum OrderTypes: Int {
    case processing
    case active
    case delivered
    
    var title: String {
        switch self {
        case .processing:
            return "in_wait".localized(using: "Localizable")
        case .active:
            return "active".localized(using: "Localizable")
        case .delivered:
            return "delivered".localized(using: "Localizable")
        }
    }
    
    var color: UIColor? {
        switch self {
        case .processing:
            return UIColor(hex: "#F8B068FF") //orange
        case .active:
            return  UIColor(hex: "#1BC06DFF") //green
        case .delivered:
            return  UIColor(hex: "#DB3022FF") //red
        }
    }
}
