//
//  BaseViewController.swift
//  24SEVEN
//
//  Created by Khushnidjon Keldiboev on 12/01/21.
//

//import UIKit
//
//class BaseViewController: UIViewController {
//    
//    var baseView = BaseView()
//    
////    var table = UITableView()
//        
//    // step 1
//    override func loadView() {
//        super.loadView()
//        
//        view = baseView
//        
////        table.dataSource = TableViewDataSource()
//    }
//
//    // step 2
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        
//        setupTargets()
//        navigationController?.navigationBar.isHidden = true
//    }
//    
//    @objc func buttonActionForAll() {
//        print("salom")
//    }
//
//}
//
//extension BaseViewController {
//    private func setupTargets() {
//        baseView.submitAction = { [weak self] in
//            // button action
//            // call network request
//            guard let self = self else {
//                return
//            }
//            
//            self.navigationController?.pushViewController(ProductViewController(), animated: true)
//            
//            print(self.view.frame.size)
//        }
//        
//        if let baseView = view as? BaseView {
//            baseView.navBarView.backButton.addTarget(self, action: #selector(popVC), for: .primaryActionTriggered)
//        }
//    }
//    
//    @objc func popVC() {
//        navigationController?.popViewController(animated: true)
//    }
//    
//}
