//
//  IBTableView.swift
//  24SEVEN
//
//  Created by Islom on 10/02/21.
//

import UIKit


class IBTableView : UITableView {
    init(cellClass: AnyClass,reuseId: String) {
        super.init(frame: .zero, style: .plain)
        style()
        setup(cellClass,reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 
extension IBTableView {
    private func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        separatorStyle = .none
        showsVerticalScrollIndicator = false
    }
    
    private func setup(_ cellClass: AnyClass?,_ reuseId: String) {
        register(cellClass, forCellReuseIdentifier: reuseId)
    }
}
