//
//  Constants.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/22/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

enum MediaItemKind {
    case book
    case movie
    case game
}

struct GoogleBooksAPIConstants {

    private static let apiKey = "AIzaSyBUUhlpyxGklV31hSETfN5bVaNgtnsgFfU"

    static func absoluteURL(withQueryParamas queryParams: [String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.googleapis.com"
        components.path = "/books/v1/volumes"
        components.queryItems = [URLQueryItem(name: "key", value: apiKey)]
        components.queryItems?.append(URLQueryItem(name: "q", value: queryParams.joined(separator: "+")))

        return components.url!
    }

    static func urlForBook(withId id: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.googleapis.com"
        components.path = "/books/v1/volumes/\(id)"
        
        return components.url!
    }

}
