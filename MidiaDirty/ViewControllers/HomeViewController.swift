//
//  HomeViewController.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/17/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let mediaItemCellIdentifier = "MediaItemCell"

    var mediaItemProvider: MediaItemProvider!
    var mediaItems: [MediaItemProvidable]!

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self

        // TODO: vista cargando
        mediaItemProvider.getLatestMediaItems(onSuccess: { [weak self] mediaItems in
            self?.mediaItems = mediaItems
            self?.collectionView.reloadData()
        }) { errorMessage in
            // TODO: mostrar mensaje de error
        }
    }

}

extension HomeViewController: UICollectionViewDataSource {

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

extension HomeViewController: UICollectionViewDelegate {

}
