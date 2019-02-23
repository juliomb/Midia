//
//  Game.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/20/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

struct Game {

    let gameId: String
    let name: String
    let coverURL: URL?

}

extension Game: MediaItemProvidable {

    var mediaItemId: String {
        return gameId
    }

    var title: String {
        return name
    }

    var imageURL: URL? {
        return coverURL
    }

}
