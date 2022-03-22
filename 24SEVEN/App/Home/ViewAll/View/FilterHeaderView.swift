//
//  FilterHeaderView.swift
//  24SEVEN
//
//  Created by Islom on 04/02/21.
//

import UIKit

class FilterHeaderView : IBView {
    
    let sortButton = UIButton.makeButton(title: "sort".localized(using: "Localizable"), size: .m, weight: .regular, imageName: Constants.sort, insets: true, imageInsets: true)
    
    let filterButton = UIButton.makeButton(title: "filter".localized(using: "Localizable"), size: .m, weight: .regular, imageName: Constants.filter, insets: true, imageInsets: true)
    
    var showSort: (() -> Void)?
    
    var showFilter: (() -> Void)?
    
    override init() {
        super.init()
        style()
        layout()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilterHeaderView {
    private func style() {
        sortButton.tintColor = UIColor.mainTextColor
        sortButton.titleLabel?.numberOfLines = 0
        
        filterButton.tintColor = UIColor.mainTextColor
    }
    
    private func layout() {
        addSubview(sortButton)
        addSubview(filterButton)
        
        sortButton.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        filterButton.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        
        NSLayoutConstraint.activate([
            sortButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            sortButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            sortButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            sortButton.trailingAnchor.constraint(lessThanOrEqualTo: filterButton.leadingAnchor, constant: -8),
            
            filterButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -24),
            filterButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupTargets() {
        sortButton.addTarget(self, action: #selector(handleSort), for: .primaryActionTriggered)
        filterButton.addTarget(self, action: #selector(handleFilter), for: .primaryActionTriggered)
    }
    
    @objc func handleSort() {
        showSort?()
    }
    
    @objc func handleFilter() {
        showFilter?()
    }
    
    
    
}
