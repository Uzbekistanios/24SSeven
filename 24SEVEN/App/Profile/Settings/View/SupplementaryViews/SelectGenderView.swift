

import UIKit

class SelectGenderView : IBView {
    
    let titleLabel = UILabel.makeLabel(string: "gender".localized(using: "Localizable"), size: .l, weight: .bold, alignment: .left)
    
    var tableView: ContentSizedTableView = {
        let tableView = ContentSizedTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.rowHeight = 35
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    let chooseLanguageButton = UIButton.makeButton(title: "change_language".localized(using: "Localizable"), size: .l, weight: .bold)
    
    var chooseLanguageHandler: (() -> Void)?
            
    override init() {
        super.init()
        
        style()
        layout()
        setupTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupTarget() {
        chooseLanguageButton.addTarget(self, action: #selector(languageAction), for: .primaryActionTriggered)
    }
    
    @objc func languageAction() {
        chooseLanguageHandler?()
    }
    
    private func style() {
        titleLabel.textColor = UIColor.mainTextColor
        chooseLanguageButton.tintColor = .defaultOrange
    }
    
    private func layout() {
        addSubview(titleLabel)
        addSubview(tableView)
        addSubview(chooseLanguageButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        
            chooseLanguageButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 12),
            chooseLanguageButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            chooseLanguageButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
