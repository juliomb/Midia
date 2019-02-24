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
    var detailedBook: Book!
    let coverURL = URL(string: "http://books.google.com/books/content?id=gp1nCoebxCAC&printsec=frontcover&img=1&zoom=1&edge=curl&imgtk=AFLRE71R548ji46kE8h4amBNrkJp2Stl-1WU9CE9qO0Wvdp_wFKKSN5ZlkMSr6WOQByhIYWfmeKjk2SloXR8JsJ2HmZf7bU6C9tuL1mTo40REgbGlU0JXJ59S6ShKTVYZ7xg76nA77qj&source=gbs_api")

    override func setUp() {
        bestBookEver = Book(bookId: "1", title: "El nombre del viento")
        detailedBook = Book(bookId: "2", title: "El temor de un hombre sabio", authors: ["Patrick R."], publishedDate:DateFormatter.booksAPIDateFormater.date(from: "2001-01-01"), description: "Librazo", coverURL: coverURL, rating: 5.0, numberOfReviews: 1, price: 10.99)
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

    func testEncodeBook() {
        let encoder = JSONEncoder()
        do {
            let bookData = try encoder.encode(bestBookEver)
            XCTAssertNotNil(bookData)
        } catch {
            XCTFail()
        }
    }
    
    func testDecodeEncodedDetailedBook() {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        do {
            let bookData = try encoder.encode(detailedBook)
            XCTAssertNotNil(bookData)
            let book = try decoder.decode(Book.self, from: bookData)
            XCTAssertNotNil(book)
            XCTAssertNotNil(book.bookId)
            XCTAssertNotNil(book.title)
            XCTAssertNotNil(book.authors)
            XCTAssert(book.authors!.count > 0)
            XCTAssertNotNil(book.publishedDate)
            XCTAssertNotNil(book.description)
            XCTAssertNotNil(book.coverURL)
        } catch {
            XCTFail()
        }
    }

}
