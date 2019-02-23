//
//  DetailViewController.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/23/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var mediaItemId: String!
    var mediaItemProvider: MediaItemProvider!
    var detailedMediaItem: MediaItemDetailProvidable? = nil

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var ratingsContainerView: UIView!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var numberOfReviewsLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingView.isHidden = false
        mediaItemProvider.getMediaItem(byId: mediaItemId, success: { [weak self] (detailedMediaItem) in
            self?.detailedMediaItem = detailedMediaItem
            self?.loadingView.isHidden = true
            self?.syncViewWithModel()
        }) { [weak self] (error) in
            let alertController = UIAlertController(title: nil, message: "Error recuperando los detalles del item. Disculpe las molestias.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                self?.dismiss(animated: true, completion: nil)
            }))
            self?.present(alertController, animated: true, completion: nil)
        }
    }

    @IBAction func didTapCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func syncViewWithModel() {
        guard let mediaItem = detailedMediaItem else {
            fatalError("we shouldn't call this method without a loaded model")
        }

        // Obligatorio
        titleLabel.text = mediaItem.title

        if let url = mediaItem.imageURL {
            imageView.loadImage(fromURL: url)
        }
        descriptionTextView.text = mediaItem.description // si es nil, pues sale vacío y todos contentos

        // StackView: si no lo tenemos, ocultamos y la stack view lo pondrá bonito
        if let creator = mediaItem.creatorName {
            creatorLabel.text = creator
        } else {
            creatorLabel.isHidden = true
        }
    }

}
