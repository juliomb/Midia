//
//  FavoritesProvidable.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/24/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

protocol FavoritesProvidable {

    func getFavoritesList() -> [MediaItemProvidable]?
    func getFavorite(withId id: String) -> MediaItemDetailProvidable?

}
