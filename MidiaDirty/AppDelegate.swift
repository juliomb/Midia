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

        let mediaItems: [MediaItemProvidable] = [Game(name: "PSE", coverURL: nil), Game(name: "FIFA", coverURL: nil), Book(bookId: "1", title: "First book"), Book(bookId: "2", title: "Second Book"), Game(name: "PSE", coverURL: nil), Game(name: "FIFA", coverURL: nil), Book(bookId: "1", title: "First book"), Book(bookId: "2", title: "Second Book")]
        homeViewController.mediaItems = mediaItems
        return true
    }

}

// TODO: eliminar, solo para demostración
struct Game {

    let name: String
    let coverURL: URL?

}

extension Game: MediaItemProvidable {

    var title: String {
        return name
    }

    var imageURL: URL? {
        return coverURL
    }

}
