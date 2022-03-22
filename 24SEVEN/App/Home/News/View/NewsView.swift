//
//  NewsView.swift
//  24SEVEN
//
//  Created by Islom on 20/02/21.
//

import UIKit

class NewsView : GenericScrollView {
    
    var viewModel: NewsViewModel? {
        didSet {
            details.dateLabel.text = viewModel?.newsItem?.createdAt
            details.descriptionLabel.text = viewModel?.newsItem?.content
            details.image.setImage(imageUrl: viewModel?.newsItem?.image ?? "")
        }
    }
    
    
    let details = NewsDetailsView()
    
    let share = ShareNewsView()
    
    override init() {
        super.init()
        
        style()
        layout()
        localize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        navBarView.title = "news".localized(using: "Localizable")
    }
    
    private func localize() {
        
    }
    
    private func layout() {
        scrollContent.addSubview(details)
        scrollContent.addSubview(share)
        
        NSLayoutConstraint.activate([
            details.topAnchor.constraint(equalTo: scrollContent.topAnchor),
            details.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            details.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            
            share.topAnchor.constraint(equalTo: details.bottomAnchor, constant: 12),
            share.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            share.bottomAnchor.constraint(equalTo: scrollContent.bottomAnchor, constant: -12),
        ])
    }
}
