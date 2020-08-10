//
//  AppDelegate.swift
//  TestLightIT
//
//  Created by Анна Яцун on 02.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let networkService = NetworkService()
        
        let coordinator = AppCoordinator(isHiddenNavigationBar: true, networkService: networkService)
        window.rootViewController = coordinator
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }
}

