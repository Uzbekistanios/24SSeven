
import UIKit
import YandexMapsMobile

class YandexMapView : GenericView {
   
    let yandexMapView : YMKMapView = {
        let map = YMKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    let pinLocation = UIImageView.makeImageView(imageName: Constants.location)
    
    let currentLocation = UIButton.makeButton(imageName: Constants.target, insets: true, cornerRadius: 20, addShadow: true)
      
    let checkoutButton = TargetButtonView(title: "select_address".localized(using: "Localizable"))
    
    var locationClosure : (() -> Void)?
    
    override init() {
        super.init()
        
        style()
        layout()
        targetsAdd()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func style() {
        checkoutButton.backgroundColor = .clear
        currentLocation.tintColor = UIColor.orange
        currentLocation.backgroundColor = .mainTextColor?.withAlphaComponent(0.2)
    }
    
    private func targetsAdd() {
        currentLocation.addTarget(self, action: #selector(showCurrent), for: .primaryActionTriggered)
    }
    
    @objc func showCurrent() {
        locationClosure?()
    }
    
    private func layout() {
        contentView.addSubview(yandexMapView)
        contentView.addSubview(pinLocation)
        contentView.addSubview(currentLocation)
        contentView.addSubview(checkoutButton)
        
        NSLayoutConstraint.activate([
            
            yandexMapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            yandexMapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            yandexMapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            yandexMapView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            pinLocation.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -20),
            pinLocation.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pinLocation.heightAnchor.constraint(equalToConstant: 40),
            pinLocation.widthAnchor.constraint(equalToConstant: 28),
            
            currentLocation.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            currentLocation.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -20),
            currentLocation.heightAnchor.constraint(equalToConstant: 40),
            currentLocation.widthAnchor.constraint(equalToConstant: 40),
  
            checkoutButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            checkoutButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            checkoutButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -19)
        ])
    }
}
