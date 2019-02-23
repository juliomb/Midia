//
//  MediaItemCollectionViewCell.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/17/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import UIKit
import SDWebImage

class MediaItemCollectionViewCell: UICollectionViewCell {

    var mediaItem: MediaItemProvidable! {
        didSet {
            titleLabel.text = mediaItem.title
            if let url = mediaItem.imageURL {
                imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
            }
        }
    }

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.sd_cancelCurrentImageLoad()
    }

}
