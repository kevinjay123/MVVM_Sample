//
//  AppDelegate.swift
//  Cocktail
//
//  Created by Kevin Chan on 2020/8/26.
//  Copyright © 2020 KevinChan. All rights reserved.
//

import UIKit
import NSObject_Rx
import RxOptional

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        return true
    }
    
    func application( _ app:UIApplication, open url:URL, options: [UIApplication.OpenURLOptionsKey :Any] = [:] ) -> Bool {
        return true
    }
}

