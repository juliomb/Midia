//
//  GoogleBooksAPIConsumerURLSession.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/22/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

class GoogleBooksAPIConsumerURLSession: MediaItemAPIConsumable {

    let session = URLSession.shared

    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error) -> Void) {

        let url = GoogleBooksAPIConstants.absoluteURL(withQueryParamas: ["2019"])

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
