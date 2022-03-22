//
//  ProfileSection.swift
//  24SEVEN
//
//  Created by Islom on 17/02/21.
//

import UIKit

enum ProfileSection: Int {
    case orders
    case favorites
    case addresses
    case payment
    case settings
    
    var vc: UIViewController {
        switch self {
        case .orders:
            return OrderViewController()
        case .favorites:
            return ViewGroupViewController(type: .favorites)
        case .addresses:
            return AddressViewController()
        case .payment:
            return PaymentOptionsViewController()
        case .settings:
            return SettingsViewController()
        }
    }
    
    var title: String {
        switch self {
        case .orders:
            return "my_orders".localized(using: "Localizable")
        case .favorites:
            return "favourite".localized(using: "Localizable")
        case .addresses:
            return "my_addresses".localized(using: "Localizable")
        case .payment:
            return "my_pay_method".localized(using: "Localizable")
        case .settings:
            return "settings".localized(using: "Localizable")
        }
    }
    
    var description: String {
        switch self {
        case .orders:
            return "12 заказов"
        case .favorites:
            return "5 товаров"
        case .addresses:
            return "3 адреса"
        case .payment:
            return "cash".localized(using: "Localizable")
        case .settings:
            return "settings_options".localized(using: "Localizable")
        }
    }
}
