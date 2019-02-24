//
//  FavoritesViewController.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/24/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var favorites: [MediaItemDetailProvidable]! = []

    let favoriteCellIdentifier = "favoriteTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: usar el provider
        favorites = [Book(bookId: "2", title: "El temor de un hombre sabio", authors: ["Patrick R."], publishedDate:DateFormatter.booksAPIDateFormater.date(from: "2001-01-01"), description: "Librazo", coverURL: nil, rating: 5.0, numberOfReviews: 1, price: 10.99)]

        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension FavoritesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: favoriteCellIdentifier) as? FavoriteTableViewCell else {
            fatalError()
        }
        cell.mediaItem = favorites[indexPath.row]
        return cell
    }

}

extension FavoritesViewController: UITableViewDelegate {

}
