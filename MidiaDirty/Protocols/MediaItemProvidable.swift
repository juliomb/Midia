//
//  MediaItemProvidable.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/17/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

protocol MediaItemProvidable {

    var mediaItemId: String { get }
    var title: String { get }
    var imageURL: URL? { get }

}
