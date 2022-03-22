//
//  SettingsView.swift
//  24SEVEN
//
//  Created by Islom on 19/02/21.
//

import UIKit

class SettingsView : GenericScrollView {
    
    let personalData = PersonalDataView()
    
    let selectGender = SelectGenderView()
    
    let targetView = TargetButtonView(title: "save_edits".localized(using: "Localizable").uppercased())
    
    override init() {
        super.init()
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        navBarView.title = "settings".localized(using: "Localizable")
    }
    
    private func layout() {
        contentView.addSubview(personalData)
        contentView.addSubview(selectGender)
        contentView.addSubview(targetView)
        
        NSLayoutConstraint.activate([
            personalData.topAnchor.constraint(equalTo: contentView.topAnchor),
            personalData.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            personalData.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            selectGender.topAnchor.constraint(equalTo: personalData.bottomAnchor),
            selectGender.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            selectGender.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            selectGender.bottomAnchor.constraint(lessThanOrEqualTo: targetView.topAnchor),
            
            targetView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            targetView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            targetView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
