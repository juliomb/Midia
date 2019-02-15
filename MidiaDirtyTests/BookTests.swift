//
//  BookTests.swift
//  MidiaDirtyTests
//
//  Created by Julio Martínez Ballester on 2/15/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import XCTest

class BookTests: XCTestCase {

    var bestBookEver: Book!

    override func setUp() {
        bestBookEver = Book(bookId: "1", title: "El nombre del viento", authors: ["Patrick Rothfuss"], publishedDate: Date(timeIntervalSinceNow: 13213), description: "Kvothe rules", coverURL: nil, rating: 5, numberOfReviews: 2131, price: 10)
    }

    func testBookExistence() {
        XCTAssertNotNil(bestBookEver)
    }

}
