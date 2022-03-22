//
//  TopProductsHeaderView.swift
//  24SEVEN
//
//  Created by Islom on 03/02/21.
//

import UIKit


class ProductHeaderView : IBView {
    
    let titleLabel = UILabel.makeLabel(string: "title_newProducts".localized(using: "Localizable"), size: .l, weight: .bold, alignment: .center)
    
    let viewAllButton = UIButton.makeButton(title: "view_all".localized(using: "Localizable"), size: .m, weight: .regular)
    
    var viewAllClosure: (() -> Void)?
    
    var title: String? {
        didSet {
            guard let title = title else { return }
            titleLabel.text = title
        }
    }
    
    override init() {
        super.init()
        style()
        layout()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        viewAllButton.backgroundColor = .clear
        viewAllButton.tintColor = .systemGray
    }
    
    private func layout() {
        addSubview(titleLabel)
        addSubview(viewAllButton)
        
        let titleLabelBottomAnchor = titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        titleLabelBottomAnchor.priority = UILayoutPriority(rawValue: 749)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabelBottomAnchor,
            
            viewAllButton.topAnchor.constraint(equalTo: topAnchor),
            viewAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    private func setupTargets() {
        viewAllButton.addTarget(self, action: #selector(viewAll), for: .primaryActionTriggered)
    }
    
    @objc func viewAll() {
        viewAllClosure?()
    }
}
