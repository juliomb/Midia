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
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let mediaItemCellIdentifier = "MediaItemCell"

    var mediaItemProvider: MediaItemProvider!
    var mediaItems: [MediaItemProvidable]! = []

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
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
                let alertController = UIAlertController(title: nil, message: "La búqueda no ha devuelto ningún resultado 😞", preferredStyle: .alert)
                self?.present(alertController, animated: true, completion: nil)
            }
            self?.activityIndicator.isHidden = true
        }) { [weak self] (error) in
            let alertController = UIAlertController(title: nil, message: "La búqueda ha fallado, por favor compruebe que tiene conexión.", preferredStyle: .alert)
            self?.present(alertController, animated: true, completion: nil)
            self?.activityIndicator.isHidden = true
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch()
    }

}
