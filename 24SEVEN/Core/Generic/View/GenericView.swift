//
//  GenericView.swift
//  24SEVEN
//
//  Created by Khushnidjon Keldiboev on 21/01/21.
//

import UIKit

class GenericView : UIView {
    
    var contentView = IBView()
    var navBarView = NavBarView()
    var contentViewBottom : NSLayoutConstraint!

    lazy var searchVC = SearchViewController()
    
    init() {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var pushVC: (() -> Void)?
}

extension GenericView {
    private func style() {
        backgroundColor = UIColor.mainBackgroundColor
    }
    
    public func setupSearchBar() {
            navBarView.addSubview(searchVC.view)
            
            NSLayoutConstraint.activate([
                searchVC.view.topAnchor.constraint(equalTo: navBarView.titleLabel.bottomAnchor),
                searchVC.view.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor),
                searchVC.view.trailingAnchor.constraint(equalTo: navBarView.trailingAnchor),
                searchVC.view.bottomAnchor.constraint(equalTo: navBarView.bottomAnchor)
            ])
    }
    
    func removeNavBar() {
        navBarView.removeFromSuperview()
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    
    private func setupGestures() {
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("tapped")
    }
    
    @objc func handlePush() {
        pushVC?()
    }
    
    private func layout() {
        addSubview(navBarView)
        addSubview(contentView)
        
        contentViewBottom = contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([
            
            navBarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            navBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: navBarView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentViewBottom
            
        ])
    }
}
