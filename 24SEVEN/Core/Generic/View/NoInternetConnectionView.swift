//
//  NoContentView.swift
//  24SEVEN
//
//  Created by Khushnidjon Keldiboev on 21/01/21.
//

import UIKit

class NoInternetConnectionView : IBView {
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "404-page")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    var noConnectionLabel = UILabel.makeLabel(string: "Нет соединения!", size: .ultraPageTitle, alignment: .center)
    var noConnectionDescriptionLabel = UILabel.makeLabel(string: "Пожалуйста, проверьте ваше интернет попробуйте еще раз", size: .m, alignment: .center)
    var tryAgainButton = UIButton.makeButton(title: "ПОПРОБУЙТЕ ЕЩЕ РАЗ", size: .l)


    override init() {
        super.init()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NoInternetConnectionView {
    func style() {
//        tryAgainButton.addLargeShadow()
    }
    
    func layout(){
        addSubview(imageView)
        addSubview(noConnectionLabel)
        addSubview(noConnectionDescriptionLabel)
        addSubview(tryAgainButton)
        
        NSLayoutConstraint.activate([
            
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -30),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            
            noConnectionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            noConnectionLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            noConnectionLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            
            noConnectionDescriptionLabel.topAnchor.constraint(equalTo: noConnectionLabel.bottomAnchor, constant: 8),
            noConnectionDescriptionLabel.leadingAnchor.constraint(equalTo: noConnectionLabel.leadingAnchor),
            noConnectionDescriptionLabel.trailingAnchor.constraint(equalTo: noConnectionLabel.trailingAnchor),
            
            tryAgainButton.topAnchor.constraint(equalTo: noConnectionDescriptionLabel.bottomAnchor, constant: 24),
            tryAgainButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tryAgainButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            
        ])
            
        
    }

}
