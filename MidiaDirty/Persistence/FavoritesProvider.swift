//
//  FavoritesProvider.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/24/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

class FavoritesProvider {

    let mediaItemKind: MediaItemKind
    let storageManager: FavoritesProvidable

    init(withMediaItemKind mediaItemKind: MediaItemKind, storageManager: FavoritesProvidable) {
        self.mediaItemKind = mediaItemKind
        self.storageManager = storageManager
    }

    convenience init(withMediaItemKind mediaItemKind: MediaItemKind) {
        switch mediaItemKind {
        case .book:
            self.init(withMediaItemKind: mediaItemKind, storageManager: UserDefaultsStorageManager())
        case .game, .movie:
            fatalError("MediaItemKind not supported yet :-( coming soon")
        }
    }

}
