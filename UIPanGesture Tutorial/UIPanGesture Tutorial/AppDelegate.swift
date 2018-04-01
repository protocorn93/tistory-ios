//
//  AppDelegate.swift
//  UIPanGesture Tutorial
//
//  Created by 이동건 on 2018. 4. 1..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        let rootVC = MainVC()
        NotificationCenter.default.addObserver(rootVC, selector: #selector(rootVC.volumeChanged(notification:)), name: Notification.Name("AVSystemController_SystemVolumeDidChangeNotification"), object: nil)
        window?.rootViewController = rootVC
        return true
    }
}

