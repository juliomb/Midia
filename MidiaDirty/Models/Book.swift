//
//  Book.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/15/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

struct Book {

    let bookId: String
    let title: String
    let authors: [String]?
    let publishedDate: Date?
    let description: String?
    let coverURL: URL?
    let rating: Float?
    let numberOfReviews: Int?
    let price: Float?

    init(bookId: String, title: String, authors: [String]? = nil, publishedDate: Date? = nil, description: String? = nil, coverURL: URL? = nil, rating: Float? = nil, numberOfReviews: Int? = nil, price: Float? = nil) {
        self.bookId = bookId
        self.title = title
        self.authors = authors
        self.publishedDate = publishedDate
        self.description = description
        self.coverURL = coverURL
        self.rating = rating
        self.numberOfReviews = numberOfReviews
        self.price = price
    }
    
}

extension Book: Codable {

    enum CodingKeys: String, CodingKey {
        case bookId = "id"
        case volumeInfo
        case saleInfo
        case imageLinks
        case listPrice
        case title
        case authors
        case publishedDate
        case description
        case coverURL = "thumbnail"
        case rating = "averageRating"
        case numberOfReviews = "ratingsCount"
        case price = "amount"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        bookId = try container.decode(String.self, forKey: .bookId)

        let volumeInfo = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .volumeInfo)

        title = try volumeInfo.decode(String.self, forKey: .title)
        authors = try volumeInfo.decodeIfPresent([String].self, forKey: .authors)

        if let publishedDateString = try volumeInfo.decodeIfPresent(String.self, forKey: .publishedDate),
            let date = DateFormatter.booksAPIDateFormater.date(from: publishedDateString) {
            publishedDate = date
        } else {
            publishedDate = nil
        }

        description = try volumeInfo.decodeIfPresent(String.self, forKey: .description)

        do {
            let imageLinks = try volumeInfo.nestedContainer(keyedBy: CodingKeys.self, forKey: .imageLinks)
            coverURL = try imageLinks.decodeIfPresent(URL.self, forKey: .coverURL)
        } catch {
            coverURL = nil
        }

        rating = try volumeInfo.decodeIfPresent(Float.self, forKey: .rating)
        numberOfReviews = try volumeInfo.decodeIfPresent(Int.self, forKey: .numberOfReviews)

        do {
            let saleInfo = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .saleInfo)
            let listPrice = try saleInfo.nestedContainer(keyedBy: CodingKeys.self, forKey: .listPrice)
            price = try listPrice.decodeIfPresent(Float.self, forKey: .price)
        } catch {
            price = nil
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(bookId, forKey: .bookId)

        var volumeInfo = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .volumeInfo)
        try volumeInfo.encode(title, forKey: .title)
        try volumeInfo.encodeIfPresent(authors, forKey: .authors)
        if let date = publishedDate {
            try volumeInfo.encode(DateFormatter.booksAPIDateFormater.string(from: date), forKey: .publishedDate)
        }
        try volumeInfo.encodeIfPresent(description, forKey: .description)

        var imageLinks = volumeInfo.nestedContainer(keyedBy: CodingKeys.self, forKey: .imageLinks)
        try imageLinks.encodeIfPresent(coverURL, forKey: .coverURL)

        try volumeInfo.encodeIfPresent(rating, forKey: .rating)
        try volumeInfo.encodeIfPresent(numberOfReviews, forKey: .numberOfReviews)

        var saleInfo = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .saleInfo)
        var listPrice = saleInfo.nestedContainer(keyedBy: CodingKeys.self, forKey: .listPrice)
        try listPrice.encodeIfPresent(price, forKey: .price)
    }

}

extension Book: MediaItemProvidable {

    var mediaItemId: String {
        return bookId
    }

    var imageURL: URL? {
        return coverURL
    }

}

extension Book: MediaItemDetailProvidable {

    var creatorName: String? {
        return authors?.joined(separator: ", ")
    }

    var creationDate: Date? {
        return publishedDate
    }

}
