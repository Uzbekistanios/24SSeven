//
//  AddressView.swift
//  24SEVEN
//
//  Created by Islom on 17/02/21.
//

import UIKit

class AddressView : GenericView {
    
    let tableView = IBTableView(cellClass: AddressTableViewCell.self, reuseId: AddressTableViewCell.reuseId)
    
    let targetView = TargetButtonView(title: "add_address".localized(using: "Localizable").uppercased())
    
    let dismissButton = UIButton.makeButton(imageName: "dismiss")
    
    var dismissHandler: (() -> Void)?
    
    override init() {
        super.init()
        
        style()
        layout()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        navBarView.title = "Адрес доставки"
        dismissButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        dismissButton.tintColor = UIColor.defaultOrange
        dismissButton.isHidden = true
    }
    
    private func addTarget() {
        dismissButton.addTarget(self, action: #selector(dismissAction), for: .primaryActionTriggered)
    }
    
    @objc func dismissAction() {
        dismissHandler?()
    }
    
    private func layout() {
       
        contentView.addSubview(tableView)
        navBarView.addSubview(dismissButton)
        contentView.addSubview(targetView)
        
        NSLayoutConstraint.activate([
            dismissButton.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor, constant: -3),
            dismissButton.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor, constant: 8),
            dismissButton.heightAnchor.constraint(equalToConstant: 36),
            dismissButton.widthAnchor.constraint(equalToConstant: 36),
            
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: targetView.topAnchor, constant: -24),
            
            targetView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            targetView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            targetView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
}
