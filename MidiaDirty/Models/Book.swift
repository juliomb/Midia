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

    // TODO: eliminar cuando tengamos la capa de red
    init(bookId: String, title: String) {
        self.bookId = bookId
        self.title = title
        authors = nil
        publishedDate = nil
        description = nil
        coverURL = nil
        rating = nil
        numberOfReviews = nil
        price = nil
    }
    
}

extension Book: Decodable {

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

}

extension Book: MediaItemProvidable {

    var imageURL: URL? {
        return coverURL
    }

}
