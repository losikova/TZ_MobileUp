//
//  AppDelegate.swift
//  TZ_MobileUp
//
//  Created by Анастасия Лосикова on 3/25/22.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var isAithorized = false {
        didSet {
            guard let window = window else { return }
            if UserDefaults.standard.bool(forKey: StringKeys.isAuthorized.rawValue) {
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

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TZ_MobileUp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

