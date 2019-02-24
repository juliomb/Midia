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

    func getMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error) -> Void) {
        success([MockMediaItem(), MockMediaItem()])
    }

    func getMediaItem(byId id: String, success: @escaping (MediaItemDetailProvidable) -> Void, failure: @escaping (Error) -> Void) {
        success(MockMediaItem())
    }

}

struct MockMediaItem: MediaItemProvidable, MediaItemDetailProvidable {

    var mediaItemId: String = "123"
    var title: String = "A title"
    var imageURL: URL? = nil
    var creatorName: String?
    var rating: Float?
    var numberOfReviews: Int?
    var creationDate: Date?
    var price: Float?
    var description: String?

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
