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
        bestBookEver = Book(bookId: "1", title: "El nombre del viento")
    }

    func testBookExistence() {
        XCTAssertNotNil(bestBookEver)
    }

    func testDecodeBookCollection() {
        guard let path = Bundle(for: type(of: self)).path(forResource: "book-search-response", ofType: "json") else {
            XCTFail()
            return
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let bookCollection = try decoder.decode(BookCollection.self, from: data)
            XCTAssertNotNil(bookCollection)
            let firstBook = bookCollection.items?.first
            XCTAssertNotNil(firstBook)
        } catch {
            XCTFail()
        }

    }

}
