//
//  GoogleBooksAPIConsumerAlamofire.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/22/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation
import Alamofire

class GoogleBooksAPIConsumerAlamofire: MediaItemAPIConsumable {
    
    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error) -> Void) {
        Alamofire.request(GoogleBooksAPIConstants.absoluteURL(withQueryParamas: ["2010"])).responseData { (response) in

            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(_):
                if let data = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let bookCollection = try decoder.decode(BookCollection.self, from: data)
                        success(bookCollection.items ?? [])
                    } catch {
                        failure(error) // Error parseando, lo enviamos directamente, no es el mismo que taskError
                    }
                } else {
                    success([])
                }
            }
        }
        
    }

}
