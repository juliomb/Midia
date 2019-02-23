//
//  AppDelegate.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/15/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let tabBarController = window?.rootViewController as? UITabBarController,
            let homeViewController = tabBarController.viewControllers?.first as? HomeViewController,
            let searchViewController = tabBarController.viewControllers?[1] as? SearchViewController else {
                fatalError("Wrong initial setup")
        }

        homeViewController.mediaItemProvider = MediaItemProvider(withMediaItemKind: .book)
        searchViewController.mediaItemProvider = MediaItemProvider(withMediaItemKind: .book)
        return true
    }

}
