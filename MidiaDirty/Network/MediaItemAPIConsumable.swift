//
//  MediaItemAPIConsumable.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/20/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

protocol MediaItemAPIConsumable {

    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error) -> Void)

}
