//
//  MediaItemProvider.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/20/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

enum MediaItemKind {
    case book
    case movie
    case game
}

class MediaItemProvider {

    let mediaItemKind: MediaItemKind
    let apiConsumer : MediaItemAPIConsumable

    private init(withMediaItemKind mediaItemKind: MediaItemKind, apiConsumer: MediaItemAPIConsumable) {
        self.mediaItemKind = mediaItemKind
        self.apiConsumer = apiConsumer
    }

    convenience init(withMediaItemKind mediaItemKind: MediaItemKind) {
        switch mediaItemKind {
        case .book:
            self.init(withMediaItemKind: mediaItemKind, apiConsumer: MockMediaItemAPIConsumer()) // TODO: cambiar cuando tengamos la verdad
        case .game, .movie:
            fatalError("MediaItemKind not supported yet :-( coming soon")
        }
    }

}

// TODO: mover a test cuando terminemos con la network layer
class MockMediaItemAPIConsumer: MediaItemAPIConsumable {

    func getLatestMediaItems() -> [MediaItemProvidable] {
        return [Game(name: "PSE", coverURL: nil), Game(name: "FIFA", coverURL: nil)]
    }

}
