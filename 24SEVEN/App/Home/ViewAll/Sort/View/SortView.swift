//
//  SortView.swift
//  24SEVEN
//
//  Created by Islom on 04/02/21.
//

import UIKit

class SortView : UIView {
    
    let pan = PanView()
    
    let tableView = IBTableView(cellClass: SortOptionsTableViewCell.self, reuseId: SortOptionsTableViewCell.reuseId)
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        style()
        layout()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        backgroundColor = UIColor.mainBackgroundColor
        pan.title = "sort_by".localized(using: "Localizable")
    }
    
    private func layout() {
        addSubview(pan)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            pan.topAnchor.constraint(equalTo: topAnchor),
            pan.leadingAnchor.constraint(equalTo: leadingAnchor),
            pan.trailingAnchor.constraint(equalTo: trailingAnchor),

            tableView.topAnchor.constraint(equalTo: pan.bottomAnchor, constant: 32),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
