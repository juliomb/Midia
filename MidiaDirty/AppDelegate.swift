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
        guard let homeViewController = window?.rootViewController as? HomeViewController else {
            fatalError("Wrong initial View Controller, expected \(HomeViewController.description())")
        }

        homeViewController.mediaItems = [Book(bookId: "1", title: "First book"), Book(bookId: "2", title: "Second Book")]
        return true
    }

}

