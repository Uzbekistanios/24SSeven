//
//  Theme.swift
//  24SEVEN
//
//  Created by Khushnidjon Keldiboev on 12/01/21.
//

import UIKit

extension UIColor {
    // TODO: set default color
    static let mainBackgroundColor = UIColor(named: "MainBackgoundColor")
    
    static let mainTextColor = UIColor(named: "MainTextColor")
    
    static let secondaryColor = UIColor.black
    
    static let tabBarItemsPrimaryColor = UIColor(named: "MainTabBarIItemsColor")
    
    public static let tabBarPrimaryColor = UIColor(named: "MainTabBarColor")
    
    static let defaultOrange = UIColor(named: "DefaultOrange") ?? UIColor.systemOrange
    
    static let defaultRed = UIColor(red: 219/255, green: 48/255, blue: 34/255, alpha: 0.08)
    
    static let mainSubviewColor = UIColor(named: "MainSubviewColor")
    
    static let mainButtonBackgrounColor = UIColor(named: "MainButtonBackgrounColor")
    
    static let numOfItems = UIColor(named: "NumOfItems")
    
    static let buttonShadow = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.08)
    
    public convenience init?(hex: String) {
            let r, g, b, a: CGFloat

            if hex.hasPrefix("#") {
                let start = hex.index(hex.startIndex, offsetBy: 1)
                let hexColor = String(hex[start...])

                if hexColor.count == 8 {
                    let scanner = Scanner(string: hexColor)
                    var hexNumber: UInt64 = 0

                    if scanner.scanHexInt64(&hexNumber) {
                        r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                        g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                        b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                        a = CGFloat(hexNumber & 0x000000ff) / 255

                        self.init(red: r, green: g, blue: b, alpha: a)
                        return
                    }
                }
            }

            return nil
        }
}
