//
//  ProductCollectionViewCell.swift
//  24SEVEN
//
//  Created by Islom on 03/02/21.
//

import UIKit

class ProductCollectionViewCell : UICollectionViewCell {
    
    weak var delegate: ProductCollectionViewCellProtocol?
    var productId: Int?
    
    var cellModelOther : CategoryProductsRelated? {
        didSet {
            guard let model = cellModelOther else {return}
            productId = model.id
            detailsView.itemImageView.setImage(imageUrl: model.image?.pathThumb ?? "")
            if model.isFavorite == true { isFavorite = true } else { isFavorite = false }
            if model.discountPercent == 0 {
                detailsView.discountView.isHidden = true
            } else {
                detailsView.discountView.discountLabel.text = "\(model.discountPercent?.description ?? "0")%"
            }
            if model.priceDiscount != nil {
                descriptionView.oldPriceLabel.attributedText = ("\(model.discountedPrice?.description ?? "")" + "money_format_sum".localized(using: "Localizable")).strikeThrough()
            } else {
                descriptionView.oldPriceLabel.text = ""
            }
            descriptionView.productNameLabel.text = model.name
            descriptionView.categoryLabel.text = model.category?.name
            descriptionView.currentPriceLabel.text = "\(model.actualPrice?.description ?? "0")" + "money_format_sum_unit".localized(using: "Localizable") + "\(model.unit?.name ?? "кг")"
            descriptionView.commentsButton.setTitle("comments_count".localized(using: "Localizable") + "(\(model.commentsCount ?? 0))", for: .normal)
        }
    }
    
    var cellModelSearched: searchItem? {
        didSet {
            guard let model = cellModelSearched else {return}
            productId = model.id
            if model.isFavorite == true { isFavorite = true } else { isFavorite = false }
            detailsView.itemImageView.setImage(imageUrl: model.image?.pathThumb ?? "")
            if model.discountPercent == 0 {
                detailsView.discountView.isHidden = true
            } else {
                detailsView.discountView.discountLabel.text = "\(model.discountPercent?.description ?? "0")%"
            }
            if model.priceDiscount != nil {
                descriptionView.oldPriceLabel.attributedText = ("\(model.discountedPrice?.description ?? "")" + "money_format_sum".localized(using: "Localizable")).strikeThrough()
            } else {
                descriptionView.oldPriceLabel.text = ""
            }
            descriptionView.productNameLabel.text = model.name
            descriptionView.categoryLabel.text = model.category?.name
            descriptionView.currentPriceLabel.text = "\(model.actualPrice?.description ?? "0")" + "money_format_sum_unit".localized(using: "Localizable") + "\(model.unit?.name ?? "кг")"
            descriptionView.commentsButton.setTitle("comments_count".localized(using: "Localizable") + "(\(model.commentsCount ?? 0))", for: .normal)
        }
    }
    
    var cellModel: MainProduct? {
        didSet {
            guard let model = cellModel else {return}
            productId = model.id
            if model.isFavorite == true { isFavorite = true } else { isFavorite = false }
            detailsView.itemImageView.setImage(imageUrl: model.image?.pathThumb ?? "")
            if model.discountPercent == 0 {
                detailsView.discountView.isHidden = true
            } else {
                detailsView.discountView.discountLabel.text = "\(model.discountPercent?.description ?? "0")%"
            }
            if model.priceDiscount != nil {
                descriptionView.oldPriceLabel.attributedText = ("\(model.discountedPrice?.description ?? "")" + "money_format_sum".localized(using: "Localizable")).strikeThrough()
            } else {
                descriptionView.oldPriceLabel.text = ""
            }
            descriptionView.productNameLabel.text = model.name
            descriptionView.categoryLabel.text = model.category?.name
            descriptionView.currentPriceLabel.text = "\(model.actualPrice?.description ?? "0")" + "money_format_sum_unit".localized(using: "Localizable") + "\(model.unit?.name ?? "кг")"
            descriptionView.commentsButton.setTitle("comments_count".localized(using: "Localizable") + "(\(model.commentsCount ?? 0))", for: .normal)
        }
    }
    
    var cellModelFavs: FavoritesItem? {
        didSet {
            guard let model = cellModelFavs else {return}
            productId = model.id
            if model.isFavorite == true { isFavorite = true } else { isFavorite = false }
            detailsView.itemImageView.setImage(imageUrl: model.image?.pathThumb ?? "")
            if model.discountPercent == 0 {
                detailsView.discountView.isHidden = true
            } else {
                detailsView.discountView.discountLabel.text = "\(model.discountPercent?.description ?? "0")%"
            }
            if model.priceDiscount != nil {
                descriptionView.oldPriceLabel.attributedText = ("\(model.discountedPrice?.description ?? "")" + "money_format_sum".localized(using: "Localizable")).strikeThrough()
            } else {
                descriptionView.oldPriceLabel.text = ""
            }
            descriptionView.productNameLabel.text = model.name
            descriptionView.categoryLabel.text = model.category?.name
            descriptionView.currentPriceLabel.text = "\(model.actualPrice?.description ?? "0")" + "money_format_sum_unit".localized(using: "Localizable") + "\(model.unit?.name ?? "кг")"
            descriptionView.commentsButton.setTitle("comments_count".localized(using: "Localizable") + "(\(model.commentsCount ?? 0))", for: .normal)
        }
    }
    
    var cellModelCategory: ViewAllItem? {
        didSet {
            guard let model = cellModelCategory else {return}
            productId = model.id
            if model.isFavorite == true { isFavorite = true } else { isFavorite = false }
            detailsView.itemImageView.setImage(imageUrl: model.image?.pathThumb ?? "")
            if model.discountPercent == 0 {
                detailsView.discountView.isHidden = true
            } else {
                detailsView.discountView.discountLabel.text = "\(model.discountPercent?.description ?? "0")%"
            }
            if model.priceDiscount != nil {
                descriptionView.oldPriceLabel.attributedText = ("\(model.discountedPrice?.description ?? "")" + "money_format_sum".localized(using: "Localizable")).strikeThrough()
            } else {
                descriptionView.oldPriceLabel.text = ""
            }
            descriptionView.productNameLabel.text = model.name
            descriptionView.categoryLabel.text = model.category?.name
            descriptionView.currentPriceLabel.text = "\(model.actualPrice?.description ?? "0")" + "money_format_sum_unit".localized(using: "Localizable") + "\(model.unit?.name ?? "кг")"
            descriptionView.commentsButton.setTitle("comments_count".localized(using: "Localizable") + "(\(model.commentsCount ?? 0))", for: .normal)
        }
    }
    
    let detailsView = ProductDetailsView()
    let descriptionView = ProductDescriptionView()
    let addToCartButton = UIButton.makeButton(imageName: Constants.addToCart, cornerRadius: 22.0, addShadow: true)
    
    var isFavorite: Bool? {
        didSet {
            guard let isFavorite = isFavorite else { return }
            if isFavorite {
                detailsView.favoriteButton.setImage(UIImage(named: Constants.favorite), for: .normal)
                detailsView.favoriteButton.tintColor = UIColor.defaultOrange
            } else {
                detailsView.favoriteButton.setImage(UIImage(named: Constants.notFavorite), for: .normal)
                detailsView.favoriteButton.tintColor = UIColor.defaultOrange
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        style()
        layout()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension ProductCollectionViewCell {
    private func style() {
        contentView.backgroundColor = UIColor.mainSubviewColor
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8.0
        addToCartButton.backgroundColor = UIColor.mainButtonBackgrounColor
        addToCartButton.tintColor = .white
    }
    
    private func layout() {
        contentView.addSubview(detailsView)
        contentView.addSubview(descriptionView)
        contentView.addSubview(addToCartButton)
        
        NSLayoutConstraint.activate([
            detailsView.topAnchor.constraint(equalTo: topAnchor),
            detailsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            descriptionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            addToCartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            addToCartButton.bottomAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: 22),
            addToCartButton.heightAnchor.constraint(equalToConstant: 44),
            addToCartButton.widthAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        isHidden = false
        isSelected = false
        isHighlighted = false
        detailsView.favoriteButton.setImage(UIImage(named: Constants.notFavorite), for: .normal)
        detailsView.favoriteButton.tintColor = UIColor.defaultOrange
    }
    
    private func setupButton() {
        detailsView.favoriteButton.addTarget(self, action: #selector(addToFavourite), for: .primaryActionTriggered)
        addToCartButton.addTarget(self, action: #selector(addToCardAction), for: .primaryActionTriggered)
    }
    
    @objc func addToCardAction() {
        delegate?.didAddToCart(self)
    }
    
    @objc func addToFavourite() {
        delegate?.didAddToFavorites(self)
    }
}

protocol ProductCollectionViewCellProtocol: AnyObject {
    func didAddToFavorites(_ cell: ProductCollectionViewCell)
    func didAddToCart(_ cell: ProductCollectionViewCell)
}
