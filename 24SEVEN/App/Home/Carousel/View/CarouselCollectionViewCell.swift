//
//  HomeCarouselCollectionViewCell.swift
//  24SEVEN
//
//  Created by Islom on 02/02/21.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    
    let carouselImageView = UIImageView.makeImageView(imageName: "Banner")
    
    let discountView = DiscountView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        carouselImageView.contentMode = .scaleAspectFit
      
    }
    
    private func layout() {
        addSubview(carouselImageView)
        addSubview(discountView)
        
        NSLayoutConstraint.activate([
            carouselImageView.topAnchor.constraint(equalTo: topAnchor),
            carouselImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            carouselImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            carouselImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            discountView.topAnchor.constraint(equalTo: topAnchor),
            discountView.leadingAnchor.constraint(equalTo: leadingAnchor),
            discountView.heightAnchor.constraint(equalToConstant: 24),
            discountView.widthAnchor.constraint(equalToConstant: 63)
        ])
    }
}
