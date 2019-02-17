//
//  MediaItemCollectionViewCell.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/17/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import UIKit

class MediaItemCollectionViewCell: UICollectionViewCell {

    var mediaItem: MediaItemProvidable! {
        didSet {
            titleLabel.text = mediaItem.title
        }
    }

    @IBOutlet private weak var titleLabel: UILabel!

}
