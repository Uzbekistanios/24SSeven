//
//  UIButtons.swift
//  24SEVEN
//
//  Created by Khushnidjon Keldiboev on 12/01/21.
//

import UIKit

extension UIButton {
    
    static func makeButton(title: String? = nil,size: UIFont.AppFontSize = .l, weight: UIFont.GolosWeight = .regular, imageName: String? = nil, insets: Bool = false, cornerRadius: CGFloat = 0.0, imageInsets: Bool = false, addShadow: Bool = false, bottomText: Bool = false) -> UIButton {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.appFont(size: size, weight: weight)
        btn.setTitle(title, for: .normal)
        btn.layer.cornerRadius = cornerRadius
        btn.backgroundColor = .clear
        
        if addShadow {
            btn.layer.shadowColor = UIColor.mainTextColor?.cgColor
            btn.layer.masksToBounds = false
            btn.layer.shadowRadius = 5
            btn.layer.shadowOpacity = 0.4
        }
        
        if let imageName = imageName {
            btn.setImage(UIImage(named:imageName), for: .normal)
            btn.imageView?.contentMode = .scaleAspectFit
        }
        
        if bottomText == true {
            btn.alignImageAndTitleVertically()
        } else {
            if insets {
                btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            }
            
            if imageInsets {
                btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
            }
          
        }
        
        return btn
    }
    
    static func makeNavBarButton() -> UIButton{
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: Constants.navBarBack), for: .normal)
        btn.backgroundColor = .clear
        btn.tintColor = UIColor.mainTextColor
        btn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return btn
    }
}
