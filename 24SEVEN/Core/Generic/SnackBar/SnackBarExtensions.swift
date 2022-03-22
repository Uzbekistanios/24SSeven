
import UIKit

extension UIViewController {
    // MARK:  for login requirement
    func snackBarForLogin(title: String = "Требуется авторизация", buttonTitle: String = "Логин") {
        CustomSnackBar.shared.show(title: title, buttonTitle: buttonTitle, buttonTitleColor: UIColor.defaultOrange, duration: .long) {
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
           
            CustomSnackBar.shared.button.isEnabled = false
            CustomSnackBar.shared.button.setTitleColor(UIColor.defaultOrange.withAlphaComponent(0.3), for: .normal)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) { 
                CustomSnackBar.shared.button.isEnabled = true
                CustomSnackBar.shared.button.setTitleColor(UIColor.defaultOrange.withAlphaComponent(1), for: .normal)
            }
        }
    }

    // MARK:  for giving info to user
    func simpleTextSnackBar(title: String) {
        if title.count >= 60 {
            TextSnackBar.shared.show(title: "\(String(title.prefix(60)))...")
        } else {
            TextSnackBar.shared.show(title: title)
        }
    }
}

