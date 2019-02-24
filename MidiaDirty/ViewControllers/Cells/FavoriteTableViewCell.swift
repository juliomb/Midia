//
//  FavoriteTableViewCell.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/24/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import UIKit
import SDWebImage

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var mediaItemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creatorsLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    var mediaItem: MediaItemDetailProvidable! {
        didSet {
            titleLabel.text = mediaItem.title
            if let url = mediaItem.imageURL {
                mediaItemImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
            }
            if let creator = mediaItem.creatorName {
                creatorsLabel.text = creator
            } else {
                creatorsLabel.isHidden = true
            }
            if let date = mediaItem.creationDate {
                creationDateLabel.text = DateFormatter.booksAPIDateFormater.string(from: date)
            } else {
                creationDateLabel.isHidden = true
            }
            if let price = mediaItem.price {
                priceLabel.text = "Price \(price)"
            } else {
                priceLabel.isHidden = true
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        mediaItemImageView.sd_cancelCurrentImageLoad()
    }

}
