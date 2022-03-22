//
//  NewsCollectionViewCell.swift
//  24SEVEN
//
//  Created by Islom on 20/02/21.
//

import UIKit

class NewsCollectionViewCell : UICollectionViewCell {
    
    let newsImageView = UIImageView.makeImageView(imageName: "")
    
    let dateLabel = UILabel.makeLabel(string: "", size: .m, weight: .regular, alignment: .left)
    
    let titleLabel = UILabel.makeLabel(string: "", size: .m, weight: .regular, alignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        contentView.backgroundColor = UIColor.mainSubviewColor
        contentView.layer.cornerRadius = 8.0
        contentView.layer.masksToBounds = true
        
        newsImageView.contentMode = .scaleAspectFit
        newsImageView.layer.cornerRadius = 8.0
        
        dateLabel.textColor = .systemGray
    }
    
    private func layout() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImageView.heightAnchor.constraint(equalToConstant: 156),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            dateLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 8),
            
            titleLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
