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
        components.host = "www.googleapis.com"
        components.path = "/books/v1/volumes"
        components.queryItems = [URLQueryItem(name: "key", value: apiKey)]
        components.queryItems?.append(URLQueryItem(name: "q", value: queryParams.joined(separator: "+")))

        return components.url!
    }

    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error) -> Void) {

        let url = absoluteURL(withQueryParamas: ["2019"])

        let task = session.dataTask(with: url) { (data, response, taskError) in

            if let taskError = taskError {
                DispatchQueue.main.async { failure(taskError) }
                return
            }

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let bookCollection = try decoder.decode(BookCollection.self, from: data)
                    DispatchQueue.main.async { success(bookCollection.items ?? []) }
                } catch {
                    DispatchQueue.main.async { failure(error) } // Error parseando, lo enviamos directamente, no es el mismo que taskError
                }
            } else {
                DispatchQueue.main.async { success([]) }
            }

        }

        task.resume()

    }

}
