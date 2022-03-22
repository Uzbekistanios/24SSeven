//
//  ProductView.swift
//  24SEVEN
//
//  Created by Islom on 11/02/21.
//

import UIKit


class ProductView: GenericScrollView {
    
    let carouselVC = CarouselViewController()
    
    let descriptionVC = DescriptionViewController()
    
    let topProductsVC = TopProductsViewController(type: .products)
    
    let feedbackVC = FeedbackViewController()
    
    var productID: Int = 1
    
    var viewModel: ProductViewModel? {
        didSet {
            navBarView.title = viewModel?.product?.name ?? "24SEVEN"
            carouselVC.imagesViewModel = viewModel?.images
            carouselVC.productViewModel = viewModel?.product
            descriptionVC.productViewModel = viewModel?.product
            topProductsVC.productViewModel = viewModel?.similarProducts
            feedbackVC.feedBackViewModel = viewModel?.comments
            feedbackVC.productId = productID
        }
    }

    override init() {
        super.init()

        setupViewModel()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViewModel() {
   
    }
        
    private func layout() {
        scrollContent.addSubview(carouselVC.view)
        scrollContent.addSubview(descriptionVC.view)
        scrollContent.addSubview(topProductsVC.view)
        scrollContent.addSubview(feedbackVC.view)

        NSLayoutConstraint.activate([
            carouselVC.view.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            carouselVC.view.topAnchor.constraint(equalTo: scrollContent.topAnchor),
            carouselVC.view.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),

            descriptionVC.view.topAnchor.constraint(equalTo: carouselVC.view.bottomAnchor),
            descriptionVC.view.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            descriptionVC.view.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            
            topProductsVC.view.topAnchor.constraint(equalTo: descriptionVC.view.bottomAnchor, constant: 24),
            topProductsVC.view.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            topProductsVC.view.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            
            feedbackVC.view.topAnchor.constraint(equalTo: topProductsVC.view.bottomAnchor, constant: 24),
            feedbackVC.view.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            feedbackVC.view.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            feedbackVC.view.bottomAnchor.constraint(lessThanOrEqualTo: scrollContent.bottomAnchor)
        ])
    }
}
