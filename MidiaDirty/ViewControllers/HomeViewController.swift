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

    let mediaItems: [MediaItemProvidable] = [Book(bookId: "1", title: "First book"), Book(bookId: "2", title: "Second Book")]

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
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
        let mediaItem = mediaItems[indexPath.row]
        cell.titleLabel.text = mediaItem.title
        return cell
    }

}

extension HomeViewController: UICollectionViewDelegate {

}
