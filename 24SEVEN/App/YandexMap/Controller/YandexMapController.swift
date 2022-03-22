
import UIKit
import CoreLocation
import YandexMapsMobile

protocol YandexMapViewControllerDelegate: AnyObject {
    func didChanged(lat: String, long: String, adress: String, district: String, city: String)
}

class YandexMapController : GenericViewController {
    
    let _view = YandexMapView()
    
    weak var delegate: YandexMapViewControllerDelegate?
    
    var locationManager: CLLocationManager = CLLocationManager()
    
    private var geoObject: YandexModel? {
        didSet {
            _view.navBarView.title = geoObject?.response?.geoObjectCollection?.featureMember?.first?.geoObject?.name
        }
    }

    let mapKit = YMKMapKit.sharedInstance()
    
    private var currentLat: Double?
    private var currentLng: Double?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        buttonHandler()
        determineMyCurrentLocation()
        
        let userLocationLayer = mapKit.createUserLocationLayer(with: (_view.yandexMapView.mapWindow)!)
      
        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.isHeadingEnabled = true
        userLocationLayer.isAutoZoomEnabled = true
        
        _view.yandexMapView.mapWindow.map.addCameraListener(with: self)
    }
    
    override func loadView() {
        view = _view
    }
    
    private func style() {
        _view.navBarView.titleLabel.font = UIFont.appFont(size: .l, weight: .regular)
        _view.navBarView.titleLabel.numberOfLines = 2
    }
    
    private func buttonHandler() {
        _view.locationClosure = { [weak self] in
            guard let self = self else { return }
            self.determineMyCurrentLocation()
        }
        
        _view.checkoutButton.targetClosure = { [weak self] in
            guard let self = self else { return }
            
            let location = self.geoObject?.response?.geoObjectCollection?.featureMember?.first?.geoObject?.point?.pos ?? ""
          
            let adress = self.geoObject?.response?.geoObjectCollection?.featureMember?.first?.geoObject?.name ?? ""
            let province = self.geoObject?.response?.geoObjectCollection?.featureMember?.first?.geoObject?.geoObjectDescription ?? ""
            let city = province.strstr(needle: ",", beforeNeedle: true) ?? ""
            
            let lat = location.strstr(needle: " ", beforeNeedle: true) ?? ""
            let long = location.strstr(needle: " ") ?? ""
            
            self.delegate?.didChanged(lat:lat, long: long, adress: adress, district: province, city: city)
            self.popVC()
        }
    }
}

extension YandexMapController : YMKMapCameraListener {
    func onCameraPositionChanged(with map: YMKMap, cameraPosition: YMKCameraPosition, cameraUpdateReason: YMKCameraUpdateReason, finished: Bool) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(requestLocation), object: nil)
        self.currentLat = cameraPosition.target.latitude
        self.currentLng = cameraPosition.target.longitude
        _view.checkoutButton.targetButton.isEnabled = false
        
        _view.navBarView.title = "Определение вашего адреса..."
        
        _view.checkoutButton.targetButton.backgroundColor = .darkGray.withAlphaComponent(0.2)
        self.perform(#selector(requestLocation), with: nil, afterDelay: 1)
    }
    
    @objc func requestLocation() {
        _view.checkoutButton.targetButton.isEnabled = true
        _view.checkoutButton.targetButton.backgroundColor = UIColor.mainButtonBackgrounColor
        getYandexInfo(long: currentLng ?? 0.0, lat: currentLat ?? 0.0)
    }
    
    func determineMyCurrentLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            checkAuthorizationStatus()
            locationManager.startUpdatingLocation()
        }
    }
    
    func checkAuthorizationStatus() {
        locationManager.requestAlwaysAuthorization()
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse: break
        case .denied: break
        case .notDetermined: locationManager.requestLocation(); break
        case .restricted: break
        case .authorizedAlways: break
        @unknown default: break
        }
    }
}


extension YandexMapController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLat = location.coordinate.latitude
            currentLng = location.coordinate.longitude
            self.locationManager.stopUpdatingLocation()
            
            getYandexInfo(long: currentLng ?? 0.0, lat: currentLat ?? 0.0)
            _view.yandexMapView.mapWindow.map.move(with: YMKCameraPosition(target: YMKPoint(latitude: currentLat ?? 0.0, longitude: currentLng ?? 0.0), zoom: 20, azimuth: 0, tilt: 0), animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 0), cameraCallback: nil)
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let alertController = UIAlertController (title: "Вы отказались от доступа к вашему местоположению", message: "Перейти в настройки?", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Настройки", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Отменить", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension YandexMapController {
    
    func getYandexInfo(long: Double, lat: Double) {
        let params: [String: AnyHashable] = [
            "apikey": ConstantsAPIKey.KEY_FOR_YANDEX_USAGE,
            "format": "json",
            "geocode" : "\(long),\(lat)",
            "results": "1",
            "lang": "ru_RU"
        ]
        
        NetworkManagerYandex.YandexMap.yandexMapData(params: params) { [weak self] (response) in
            guard let self = self else {return}
            switch response.result {
            case .success(let data):
                self.geoObject = data
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
