//
//  TopProducts.swift
//  24SEVEN
//
//  Created by Islom on 20/02/21.
//

import UIKit

enum TopProductTypes {
    case products
    case news
    
    var vc: UIViewController {
        switch self {
        case .products:
            return ProductViewController()
        case .news:
            return NewsViewController()
        }
    }
    
    var viewAllVC: UIViewController {
        switch self {
        case .products:
            return ViewAllViewController()
        case .news:
            return ViewGroupViewController(type: .news)
        }
    }
}
