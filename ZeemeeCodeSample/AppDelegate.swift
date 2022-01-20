//
//  AppDelegate.swift
//  ZeemeeCodeSample
//
//  Created by Nicholas Peterson on 1/19/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let bootstrap = Bootstrap() // Holds the top level objects for basic app functions and inital state

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        bootstrap.start()
        return true
    }

}

class Bootstrap {
    let navigationController = UINavigationController(rootViewController: SearchViewController())
    let mainWindow = UIWindow()
    
    func start() {
        mainWindow.rootViewController = navigationController
        mainWindow.makeKeyAndVisible() //TODO: IOS13 throws a soft-warning "UIWindows were created prior to initial application activation. This may result in incorrect visual appearance."
    }
}
