//
//  GoogleBooksAPIConsumerURLSession.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/22/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

class GoogleBooksAPIConsumerURLSession: MediaItemAPIConsumable {

    let apiKey = "AIzaSyBUUhlpyxGklV31hSETfN5bVaNgtnsgFfU"

    let session = URLSession.shared

    func absoluteURL(withQueryParamas queryParams: [String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "googleapis.com"
        components.path = "/books/v1/volumes"
        components.queryItems = [URLQueryItem(name: "key", value: apiKey)]
        components.queryItems?.append(URLQueryItem(name: "q", value: queryParams.joined(separator: "+")))

        return components.url!
    }

    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error) -> Void) {

    }

}
