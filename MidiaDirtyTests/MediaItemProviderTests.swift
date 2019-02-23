//
//  MediaItemProviderTests.swift
//  MidiaDirtyTests
//
//  Created by Julio Martínez Ballester on 2/23/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import XCTest
@testable import MidiaDirty

class MockMediaItemAPIConsumer: MediaItemAPIConsumable {

    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error) -> Void) {
        success([MockMediaItem(), MockMediaItem()])
    }

}

struct MockMediaItem: MediaItemProvidable {

    var title: String = "A title"
    var imageURL: URL? = nil

}

class MediaItemProviderTests: XCTestCase {

    var mediaItemProvider: MediaItemProvider!
    var mediaItemConsumer: MockMediaItemAPIConsumer!

    override func setUp() {
        super.setUp()

        mediaItemConsumer = MockMediaItemAPIConsumer()
        mediaItemProvider = MediaItemProvider.init(withMediaItemKind: .book, apiConsumer: mediaItemConsumer)
    }

    func testGetLatestMediaItems() {
        mediaItemProvider.getLatestMediaItems(onSuccess: { (mediaItems) in
            XCTAssertNotNil(mediaItems)
            XCTAssert(mediaItems.count > 0)
            XCTAssertNotNil(mediaItems.first?.title)
        }) { (error) in
            XCTFail()
        }
    }

}
