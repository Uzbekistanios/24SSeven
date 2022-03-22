//
//  ProductViewController.swift
//  24SEVEN
//
//  Created by Islom on 11/02/21.
//

import UIKit

class ProductViewController : GenericViewController {
    
    let _view = ProductView()
    
    let viewModel = ProductViewModel() 
    
    var productID: Int? {
        didSet {
            _view.productID = productID ?? 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        super.loadView()
        view = _view
        
        viewModel.delegate = self
        viewModel.fetchMainProductItem(productId: productID ?? 1)
    }
}

extension ProductViewController {
    private func setup() {
        addChildToScroll(vc: _view.carouselVC)
        addChildToScroll(vc: _view.descriptionVC)
        addChildToScroll(vc: _view.topProductsVC)
        addChildToScroll(vc: _view.feedbackVC)
    }
}

extension ProductViewController : ProductViewModelProtocol {
    func didUpdateProductItem() {
        _view.viewModel = viewModel
        _view.carouselVC.carouselView.collectionView.reloadData()
    }
}
