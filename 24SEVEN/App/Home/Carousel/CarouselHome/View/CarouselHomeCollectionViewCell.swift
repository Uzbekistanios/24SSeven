

import UIKit

class CarouselHomeCollectionViewCell: UICollectionViewCell {
    
    let carouselImageView = UIImageView.makeImageView(imageName: "Banner")
    
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
             
        NSLayoutConstraint.activate([
            carouselImageView.topAnchor.constraint(equalTo: topAnchor),
            carouselImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            carouselImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            carouselImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
