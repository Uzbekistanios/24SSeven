//
//  SearchView.swift
//  24SEVEN
//
//  Created by Islom on 01/02/21.
//

import UIKit

class SearchTextField : CustomTextField {
    
    var searchImage = UIImageView.makeImageView(imageName: Constants.search)

    var voiceButton = UIButton.makeButton(imageName: Constants.microphone, insets: false)
    
    var voiceButtonHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        style()
        layout()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupTargets() {
        voiceButton.addTarget(self, action: #selector(voiceAction), for: .primaryActionTriggered)
    }
    
    @objc func voiceAction() {
        voiceButtonHandler?()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = rect.height / 2.0
        clipsToBounds = true
    }
    
    private func style() {
        voiceButton.isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.mainSubviewColor
        tintColor = UIColor.defaultOrange
        padding = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 40)
        textColor = UIColor.defaultOrange
        attributedPlaceholder = NSAttributedString(string: "search".localized(using: "Localizable"), attributes: [.foregroundColor: UIColor.defaultOrange])
        voiceButton.tintColor = UIColor.defaultOrange
    }
    
    private func layout() {
        addSubview(searchImage)
        addSubview(voiceButton)
        
        NSLayoutConstraint.activate([
            searchImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchImage.centerYAnchor.constraint(equalTo: centerYAnchor),

            voiceButton.centerYAnchor.constraint(equalTo: searchImage.centerYAnchor),
            voiceButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
}
