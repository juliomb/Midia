//
//  HomeViewController.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/17/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    enum HomeViewControllerState {
        case loading
        case noResults
        case noConnection
        case ready
    }

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var stateEmojiLabel: UILabel!
    @IBOutlet weak var stateTextLabel: UILabel!

    var state: HomeViewControllerState = .loading {
        willSet {
            guard state != newValue else { return }

            // Ocultamos todo  y después mostramos lo correcto
            for view: UIView in [collectionView, activityIndicator, stateEmojiLabel, stateTextLabel] {
                view.isHidden = true
            }

            switch newValue {
            case .loading:
                activityIndicator.isHidden = false
            case .noResults:
                stateEmojiLabel.isHidden = false
                stateTextLabel.isHidden = false
                stateEmojiLabel.text = "☹️"
                stateTextLabel.text = "No hay nada!!!"
            case .noConnection:
                stateEmojiLabel.isHidden = false
                stateTextLabel.isHidden = false
                stateEmojiLabel.text = "❌"
                stateTextLabel.text = "No hay conexión"
            case .ready:
                collectionView.isHidden = false
                collectionView.reloadData()
            }
        }
    }

    let mediaItemCellIdentifier = "MediaItemCell"

    var mediaItemProvider: MediaItemProvider!
    var mediaItems: [MediaItemProvidable]! = []

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self

        mediaItemProvider.getLatestMediaItems(onSuccess: { [weak self] mediaItems in
            self?.mediaItems = mediaItems
            self?.state = mediaItems.count > 0 ? .ready : .noResults
        }) { [weak self] errorMessage in
            self?.state = .noConnection
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

    // TODO: al seleccionar media item, ir al detalle

}
