//
//  ViewGroupTypes.swift
//  24SEVEN
//
//  Created by Islom on 20/02/21.
//

import UIKit

enum ViewGroupTypes {
    case news
    case favorites
    
    var title: String {
        switch self {
        case .news:
            return "news".localized(using: "Localizable")
        case .favorites:
            return "title_myFavourites".localized(using: "Localizable")
        }
    }
    
    var vc: UIViewController {
        switch self {
        case .news:
            return NewsViewController()
        case .favorites:
            return ProductViewController()
        }
    }
}
