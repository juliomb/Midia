//
//  SearchViewController.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/23/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let mediaItemCellIdentifier = "MediaItemCell"

    var mediaItemProvider: MediaItemProvider!
    var mediaItems: [MediaItemProvidable]! = []

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func performSearch() {
        guard let searchText = searchBar.text else {
            return
        }
        activityIndicator.isHidden = false
        mediaItemProvider.getMediaItems(withQueryParams: searchText, success: { [weak self] (mediaItems) in
            self?.mediaItems = mediaItems
            self?.collectionView.reloadData()
            if mediaItems.count == 0 {
                self?.presentSimpleAlertController(withMessage: "La búqueda no ha devuelto ningún resultado 😞")
            }
            self?.activityIndicator.isHidden = true
        }) { [weak self] (error) in
            self?.presentSimpleAlertController(withMessage: "La búqueda ha fallado, por favor compruebe que tiene conexión.")
            self?.activityIndicator.isHidden = true
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch()
    }

}


extension SearchViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mediaItemCellIdentifier, for: indexPath) as? MediaItemCollectionViewCell else {
            fatalError()
        }
        cell.mediaItem = mediaItems[indexPath.row]
        return cell
    }

}

extension SearchViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailViewController = UIStoryboard(name: "Detail", bundle: nil).instantiateInitialViewController() as? DetailViewController else {
            fatalError()
        }
        let mediaItem = mediaItems[indexPath.row]
        detailViewController.mediaItemId = mediaItem.mediaItemId
        detailViewController.mediaItemProvider = mediaItemProvider

    }

}
