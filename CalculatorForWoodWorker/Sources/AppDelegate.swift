//
//  AppDelegate.swift
//  CalculatorForWoodWorker
//
//  Created by HS Song on 2016. 3. 1..
//  Copyright © 2016년 softdevstory. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        
        let rootViewController = MainTabBarViewController()
        window.rootViewController = rootViewController
        
        self.window = window
      
        return true
    }
}

