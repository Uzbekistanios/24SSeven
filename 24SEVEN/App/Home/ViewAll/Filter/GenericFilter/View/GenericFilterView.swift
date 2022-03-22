//
//  GenericFilterView.swift
//  24SEVEN
//
//  Created by Islom on 26/02/21.
//

import UIKit

class GenericFilterView : UIView {
    
    let navBarView = FilterNavBarView()
    
    let tableView = IBTableView(cellClass: FilterTableViewCell.self, reuseId: FilterTableViewCell.reuseId)
    
    let clearButton = UIButton.makeButton(title: "reset".localized(using: "Localizable"), size: .l, weight: .bold)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        style()
        layout()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        backgroundColor = UIColor.mainBackgroundColor
    
        clearButton.setTitleColor(UIColor.mainTextColor, for: .normal)
    }
    
    private func layout() {
        addSubview(navBarView)
        addSubview(tableView)
        addSubview(clearButton)
        
        NSLayoutConstraint.activate([
            navBarView.topAnchor.constraint(equalTo: topAnchor),
            navBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: clearButton.topAnchor, constant: -16),
            
            clearButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -36),
            clearButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
    }
    
    private func setup() {
        tableView.register(FilterDetailsTableViewCell.self, forCellReuseIdentifier: FilterDetailsTableViewCell.reuseId)
    }
}
