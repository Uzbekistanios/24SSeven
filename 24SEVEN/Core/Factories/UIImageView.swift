//
//  UIImageView.swift
//  24SEVEN
//
//  Created by Islom on 30/01/21.
//

import UIKit

extension UIImageView {
    static func makeImageView(imageName: String) -> UIImageView{
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: imageName)
        return imageView
    }
}
