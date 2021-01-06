//
//  AppDelegate.swift
//  GWDrawEngine
//
//  Created by 陈琪 on 2020/6/23.
//  Copyright © 2020 Chen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        Application.shared.startService()
        
        let vc = ViewController()
        let root = UINavigationController.init(rootViewController: vc)
        UIApplication.shared.statusBarStyle = .lightContent
        window?.rootViewController = root
        window?.makeKeyAndVisible()
        return true
    }


}

