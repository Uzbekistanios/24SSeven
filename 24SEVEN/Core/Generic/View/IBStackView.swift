//
//  IBStackView.swift
//  24SEVEN
//
//  Created by Islom on 08/02/21.
//

import UIKit

class IBStackView : UIStackView {
    
    init(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution,  alignment: UIStackView.Alignment) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}
