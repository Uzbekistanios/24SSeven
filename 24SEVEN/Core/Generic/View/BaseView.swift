//
//  BaseView.swift
//  24SEVEN
//
//  Created by Khushnidjon Keldiboev on 12/01/21.
//

import UIKit

//class BaseView: UIView {
//    
//    var navBarView = NavBarView()
//    
//    var pageLabel = UILabel.makeLabel(alignment: .center)
//    
//    var submitButton = UIButton.makeButton(title: "asdas")
//    
//    var contentView = UIView(frame: .zero)
//    
//    var activityIndicator: UIActivityIndicatorView = {
//        let i = UIActivityIndicatorView(style: .gray)
//        i.translatesAutoresizingMaskIntoConstraints = false
//        
//        return i
//    }()
//    
//    // actions
//    var submitAction: (() -> Void)?
//    
//    private func layout() {
//        addSubview(pageLabel)
//        addSubview(submitButton)
//        addSubview(activityIndicator)
//        addSubview(navBarView)
//        
//        NSLayoutConstraint.activate([
//            navBarView.topAnchor.constraint(equalTo: topAnchor),
//            navBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            navBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            
//            pageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            pageLabel.topAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: 24),
//            
//            submitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
//            submitButton.topAnchor.constraint(equalTo: pageLabel.bottomAnchor, constant: 24),
//            
//            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
//            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
//        ])
//    }
//    
//    private func setupTargets() {
////        submitButton.addTarget(self, action: #selector(handleSubmit), for: .primaryActionTriggered)
//    }
//    
//    @objc private func handleSubmit() {
//        // animation
//        // submitButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
//        
//        submitAction?()
//    }
//    
//    init() {
//        super.init(frame: .zero)
//        
//        backgroundColor = .white
//        
//        
//        layout()
//        setupTargets()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError()
//    }
//}
