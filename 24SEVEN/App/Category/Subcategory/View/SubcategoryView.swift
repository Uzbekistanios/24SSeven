//
//  SubcategoryView.swift
//  24SEVEN
//
//  Created by Islom on 08/02/21.
//

import UIKit

class SubcategoryView : GenericView {
    
    let selectCategoryLabel = UILabel.makeLabel(string: "Выберите категорию", size: .l, weight: .regular, alignment: .left)
    
    let tableView = UITableView()
    
    override init() {
        super.init()
        setupSearchBar()
        setupTableView()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SubcategoryTableViewCell.self, forCellReuseIdentifier: SubcategoryTableViewCell.reuseId)
    }
    
    private func style() {
        selectCategoryLabel.textColor = UIColor.defaultOrange
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
    
    private func layout() {
        contentView.addSubview(selectCategoryLabel)
        contentView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            selectCategoryLabel.topAnchor.constraint(equalTo: searchVC.searchAndScanView.bottomAnchor, constant: 20),
            selectCategoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            selectCategoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: selectCategoryLabel.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14)
        ])
    }
}
