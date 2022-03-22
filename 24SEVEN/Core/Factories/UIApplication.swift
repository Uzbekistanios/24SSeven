//
//  UIApplication.swift
//  24SEVEN
//
//  Created by Khushnidjon Keldiboev on 27/03/21.
//

import UIKit

extension UIApplication {
   
    class func getTopView() -> UIView? {
        var window = UIApplication.shared.keyWindow
        if window == nil{
            window = UIApplication.shared.windows[0]
        }
        if window?.subviews.count == 0 {
            return nil
        }
        let topView = window?.subviews.last
        return topView
    }
}
