//
//  AppDelegate.swift
//  24SEVEN
//
//  Created by Khushnidjon Keldiboev on 12/01/21.
//

import UIKit
import RealmSwift
import YandexMapsMobile

import netfox

var uiRealm = try! Realm()

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MARK:  Setup YandexMapKit
        YMKMapKit.setApiKey(ConstantsAPIKey.KEY_FOR_YANDEX_USAGE_MAP)

        // MARK:  netfox
        #if DEBUG
        NFX.sharedInstance().start()
        #endif
        
        // MARK:  realmMain
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("realmMain.realm")
        Realm.Configuration.defaultConfiguration = config
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "")
        
        // MARK:  Loading All existing fonts
        UIFont.loadAllFonts()
        
        // MARK: checking for network
        InternetReachability.sharedInstance.observeReachability()
        
        
        //setting Window with Tab Bar
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = DefaultTabBarController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

