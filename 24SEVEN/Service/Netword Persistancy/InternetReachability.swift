
import UIKit

class InternetReachability {
    
    static let sharedInstance = InternetReachability()
    private var reachability: Reachability!
    let sharedView = NoInternetViewController()
    
    func observeReachability() {
        self.reachability = try! Reachability()
        NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
        do {
            try self.reachability.startNotifier()
        } catch(let error) {
            print("Error occured: \(error.localizedDescription)")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        var isReachable = true
        switch reachability.connection {
        case .cellular:
            print("Network via Cellular Data.")
            isReachable = true
            break
        case .wifi:
            print("Network via WiFi.")
            isReachable = true
            break
        case .none:
            print("Network is not available.")
            isReachable = false
            break
        case .unavailable:
            isReachable = false
            print("Network is not available.")
        }
        showHideView(isReachable: isReachable)
    }
    
    func showHideView(isReachable:Bool){
        if isReachable {
            
            UIView.animate(withDuration: 0.4, animations: {
                self.sharedView.view.alpha = 0
            }) { _ in
                self.sharedView.view.removeFromSuperview()
            }
          
            NotificationCenter.default.post(name: Notification.Name(rawValue: "NetWorkNotification"), object: nil)
            
        } else {
            
            UIView.animate(withDuration: 0.4) {
                self.sharedView.view.alpha = 1
                UIApplication.getTopView()?.addSubview(self.sharedView.view)
            }

        }
    }
}
