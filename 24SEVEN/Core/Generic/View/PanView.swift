//
//  PanView.swift
//  24SEVEN
//
//  Created by Islom on 25/02/21.
//

import UIKit

class PanView : IBView {
   
    let panImage = UIImageView.makeImageView(imageName: Constants.panButton)
    
    let sortLabel = UILabel.makeLabel(string: "sort".localized(using: "Localizable"), size: .xl, weight: .bold, alignment: .center)
    
    var title: String? {
        didSet {
            guard let title = title else { return }
            sortLabel.text = title
        }
    }
    
    override init() {
        super.init()
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        backgroundColor = .clear
        panImage.tintColor = .systemGray
    }
    
    private func layout() {
        addSubview(panImage)
        addSubview(sortLabel)
        
        NSLayoutConstraint.activate([
            panImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            panImage.heightAnchor.constraint(equalToConstant: 6),
            panImage.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            
            sortLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            sortLabel.topAnchor.constraint(equalTo: panImage.bottomAnchor, constant: 16),
            sortLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
