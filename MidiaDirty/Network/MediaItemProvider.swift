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
            self.init(withMediaItemKind: mediaItemKind, apiConsumer: GoogleBooksAPIConsumerURLSession())
        case .game, .movie:
            fatalError("MediaItemKind not supported yet :-( coming soon")
        }
    }

    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (String) -> Void) {
        apiConsumer.getLatestMediaItems(onSuccess: { (mediaItems) in
            // chequeamos que estamos volviendo en el hilo principal
            assert(Thread.current == Thread.main)
            // podríamos guardar en caché y presentar en caso de error por ejemplo
            success(mediaItems)
        }) { (error) in
            // chequeamos que estamos volviendo en el hilo principal
            assert(Thread.current == Thread.main)
            failure(error.localizedDescription)
        }
    }

}

// TODO: mover a test cuando terminemos con la network layer
class MockMediaItemAPIConsumer: MediaItemAPIConsumable {

    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error) -> Void) {
        success([Game(name: "PSE", coverURL: nil), Game(name: "FIFA", coverURL: nil)])
    }

}
