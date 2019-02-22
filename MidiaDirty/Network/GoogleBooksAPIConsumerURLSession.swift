//
//  GoogleBooksAPIConsumerURLSession.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/22/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

class GoogleBooksAPIConsumerURLSession: MediaItemAPIConsumable {

    let baseURL = URL(string: "https://www.googleapis.com/books/v1/volumes?q=")!
    let apiKey = "AIzaSyBUUhlpyxGklV31hSETfN5bVaNgtnsgFfU"

    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error) -> Void) {

    }

}
