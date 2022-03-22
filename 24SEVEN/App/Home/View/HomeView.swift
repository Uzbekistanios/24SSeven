//
//  HomeView.swift
//  24SEVEN
//
//  Created by Islom on 02/02/21.
//

import UIKit

class HomeView: GenericScrollView {
    
    let stackView = IBStackView(axis: .vertical, distribution: .fill, alignment: .fill)
    
    override init() {
        super.init()
        setupSearchBar()
        setupStackView()
        layout()
        localize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupStackView() {
        stackView.spacing = 24.0
    }
    
    private func layout() {
        scrollContent.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollContent.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: scrollContent.bottomAnchor),
        ])
    }
    
    func localize() {
        navBarView.title = "Home"
    }
}
