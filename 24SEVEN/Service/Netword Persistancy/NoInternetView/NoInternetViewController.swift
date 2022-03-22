
import UIKit

class NoInternetViewController: UIViewController {

    lazy var imageView = NYImageView(imageName: "404-page", contentMode: .scaleAspectFit)
    lazy var lbl_title = UILabel.makeLabel(size: .ultraPageTitle, weight: .bold, alignment: .center)
    lazy var lblSubtitle = UILabel.makeLabel(size: .m, weight: .regular, alignment: .center)
    let btnHome = TargetButtonView(title: "try_again".localized(using: "Localizable"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTargets()
        setupConstraints()
        localize()
        style()
      
    }
}

extension NoInternetViewController {
    
    private func style() {
        view.backgroundColor = UIColor.mainBackgroundColor
        lbl_title.textColor = UIColor.mainTextColor
        lblSubtitle.textColor = UIColor.mainTextColor
    }
    
    private func setupTargets() {
        btnHome.targetClosure = {
//            InternetReachability.sharedInstance.observeReachability()
        }
    }
    
    private func localize() {
        lbl_title.text = "no_connection".localized(using: "Localizable")
        lblSubtitle.text = "no_connection_try_again".localized(using: "Localizable")
    }
 
    private func setupConstraints() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(imageView)
        self.view.addSubview(lbl_title)
        self.view.addSubview(lblSubtitle)
        self.view.addSubview(btnHome)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            imageView.leadingAnchor.constraint(equalTo: lbl_title.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: lbl_title.trailingAnchor),
           
            lbl_title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            lbl_title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            lbl_title.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            lblSubtitle.topAnchor.constraint(equalTo: lbl_title.bottomAnchor, constant: 8),
            lblSubtitle.leadingAnchor.constraint(equalTo: lbl_title.leadingAnchor),
            lblSubtitle.trailingAnchor.constraint(equalTo: lbl_title.trailingAnchor),
            
            btnHome.topAnchor.constraint(equalTo: lblSubtitle.bottomAnchor, constant: 24),
            btnHome.leadingAnchor.constraint(equalTo: lbl_title.leadingAnchor),
            btnHome.trailingAnchor.constraint(equalTo: lbl_title.trailingAnchor),
        ])
    }
}
