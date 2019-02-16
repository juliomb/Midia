//
//  BookCollection.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/16/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

struct BookCollection: Decodable {

    let kind: String
    let totalItems: Int
    let items: [Book]?

}
