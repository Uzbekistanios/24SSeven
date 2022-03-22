//
//  NewsDetailsView.swift
//  24SEVEN
//
//  Created by Islom on 20/02/21.
//

import UIKit

class NewsDetailsView : IBView {
    
    let image = UIImageView.makeImageView(imageName: "")
    
    let dateLabel = UILabel.makeLabel(string: "", size: .m, weight: .regular, alignment: .center)
    
    let titleLabel = UILabel.makeLabel(string: "", size: .l, weight: .black, alignment: .left)
    
    let descriptionLabel = UILabel.makeLabel(string: "", size: .m, weight: .regular, alignment: .left)
    
    override init() {
        super.init()
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        dateLabel.textColor = UIColor.defaultOrange
        image.contentMode = .redraw

    }
    
    private func layout() {
        addSubview(image)
        addSubview(dateLabel)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            image.heightAnchor.constraint(equalToConstant: 200),
            
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
