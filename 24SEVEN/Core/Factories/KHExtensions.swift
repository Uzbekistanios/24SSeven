
import UIKit
//import Kingfisher
import SDWebImage
import SDWebImageSVGCoder


extension String {
    func phoneFormat(with mask: String) -> String {
        let numbers = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func removeAllSpaces() -> String {
        String(self.filter{ !" ".contains($0)})
    }
    
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: NSUnderlineStyle.single.rawValue,
            range:NSMakeRange(0,attributeString.length))
        return attributeString
    }
    
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func verifyUrl (urlString: String?) -> Bool {
       if let urlString = urlString {
           if let url = NSURL(string: urlString) {
               return UIApplication.shared.canOpenURL(url as URL)
           }
       }
       return false
   }
    
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}

extension UIImageView{
    func setImage(imageUrl: String) {
        self.sd_setImage(with: URL(string: imageUrl), placeholderImage:  UIImage(named: "LargeLogo"))
    }
    func setImageForItem(imageUrl: String) {
        self.sd_setImage(with: URL(string: imageUrl), placeholderImage:  UIImage(named: "LargeLogo"))

    }
}


public func jsonToData(jsonDic:Dictionary<String, Any>) -> Data? {
    if (!JSONSerialization.isValidJSONObject(jsonDic)) {
        print("is not a valid json object")
        return nil
    }
    let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [])
    let str = String(data:data!, encoding: String.Encoding.utf8)
    print("Json Str:\(str!)")
    return data
}

extension String {
    
    func strstr(needle: String, beforeNeedle: Bool = false) -> String? {
        guard let range = self.range(of: needle) else { return nil }
        
        if beforeNeedle {
            return self.substring(to: range.lowerBound)
        }
        
        return self.substring(from: range.upperBound)
    }
    
}

extension UINavigationController {
    func popViewControllers(viewsToPop: Int, animated: Bool = true) {
        if viewControllers.count > viewsToPop {
            let vc = viewControllers[viewControllers.count - viewsToPop - 1]
            popToViewController(vc, animated: animated)
        }
    }
    
}

func verifyUrl (urlString: String?) -> Bool {
    if let urlString = urlString {
        if let url = NSURL(string: urlString) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
    }
    return false
}

extension UIViewController {
    
    func showAlert(title: String?, message: String?, buttonTitles: [String]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.count == 0 {
            allButtons.append("OK")
        }
        
        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                completion?(index)
            })
            
            alertController.addAction(action)
            
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                alertController.preferredAction = action
            }
        }
        present(alertController, animated: true, completion: nil)
        
        return alertController
    }
}

func downloadImage(with urlString : String , imageCompletionHandler: @escaping (UIImage?) -> Void){
//    guard let url = URL.init(string: urlString) else {
//        return  imageCompletionHandler(nil)
//    }
//    let resource = ImageResource(downloadURL: url)
//
//    KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
//        switch result {
//        case .success(let value):
//            imageCompletionHandler(value.image)
//        case .failure:
//            imageCompletionHandler(nil)
//        }
//    }
}

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}

func showActivityIndicator(view: UIView, targetVC: UIViewController) {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    activityIndicator.backgroundColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1)
    activityIndicator.layer.cornerRadius = 6
    activityIndicator.center = targetVC.view.center
    activityIndicator.hidesWhenStopped = true
    activityIndicator.style = UIActivityIndicatorView.Style.gray
    activityIndicator.tag = 1
    view.addSubview(activityIndicator)
    activityIndicator.startAnimating()
    UIApplication.shared.beginIgnoringInteractionEvents()
}

func hideActivityIndicator(view: UIView) {
    let activityIndicator = view.viewWithTag(1) as? UIActivityIndicatorView
    activityIndicator?.stopAnimating()
    activityIndicator?.removeFromSuperview()
    UIApplication.shared.endIgnoringInteractionEvents()
}


extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

func restartApplication () {
    let viewController = DefaultTabBarController()
    let navCtrl = UINavigationController(rootViewController: viewController)
    
    guard let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController else { return }
    
    navCtrl.view.frame = rootViewController.view.frame
    navCtrl.navigationBar.isHidden = true
    navCtrl.view.layoutIfNeeded()
    
    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
        window.rootViewController = navCtrl
    })
    
}
