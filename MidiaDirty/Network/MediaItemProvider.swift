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

    init(withMediaItemKind mediaItemKind: MediaItemKind, apiConsumer: MediaItemAPIConsumable) {
        self.mediaItemKind = mediaItemKind
        self.apiConsumer = apiConsumer
    }

    convenience init(withMediaItemKind mediaItemKind: MediaItemKind) {
        switch mediaItemKind {
        case .book:
            self.init(withMediaItemKind: mediaItemKind, apiConsumer: GoogleBooksAPIConsumerAlamofire())
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

    func getMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (String) -> Void) {
        apiConsumer.getMediaItems(withQueryParams: queryParams, success: { (mediaItems) in
            assert(Thread.current == Thread.main)
            success(mediaItems)
        }) { (error) in
            assert(Thread.current == Thread.main)
            failure(error.localizedDescription)
        }
    }

    func getMediaItem(byId id: String, success: @escaping (MediaItemDetailProvidable) -> Void, failure: @escaping (String) -> Void) {
        apiConsumer.getMediaItem(byId: id, success: { (detailedMediaItem) in
            assert(Thread.current == Thread.main)
            success(detailedMediaItem)
        }) { (error) in
            assert(Thread.current == Thread.main)
            failure(error.localizedDescription)
        }
    }

}
