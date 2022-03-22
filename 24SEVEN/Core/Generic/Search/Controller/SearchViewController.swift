//
//  SearchViewController.swift
//  24SEVEN
//
//  Created by Islom on 01/02/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    let searchAndScanView = SearchAndScanView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        super.loadView()
        view = searchAndScanView
    }
}
