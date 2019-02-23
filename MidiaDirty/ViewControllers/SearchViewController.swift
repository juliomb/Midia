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

    let mediaItemCellIdentifier = "MediaItemCell"

    var mediaItemProvider: MediaItemProvider!
    var mediaItems: [MediaItemProvidable]! = []

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }

}

extension SearchViewController: UISearchBarDelegate {



}
