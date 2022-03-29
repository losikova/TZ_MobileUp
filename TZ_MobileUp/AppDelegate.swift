//
//  AppDelegate.swift
//  TZ_MobileUp
//
//  Created by Анастасия Лосикова on 3/25/22.
//

import UIKit
import SwiftKeychainWrapper

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var isAithorized = false {
        didSet {
            guard let window = window else { return }
            if UserDefaults.standard.bool(forKey: StringKeys.isAuthorized.rawValue) &&
                UserDefaults.standard.double(forKey: StringKeys.tokenExpireDate.rawValue) > Date().timeIntervalSince1970
            {
                window.rootViewController = UINavigationController(rootViewController: GalleryViewController())
            } else {
                window.rootViewController = LoginViewController()
            }
            window.makeKeyAndVisible()
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        
        if UserDefaults.standard.bool(forKey: StringKeys.isAuthorized.rawValue) {
            isAithorized = true
        } else {
            isAithorized = false
        }
        return true
    }
}

