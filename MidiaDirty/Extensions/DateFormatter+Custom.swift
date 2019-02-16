//
//  DateFormatter+Custom.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/16/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

extension DateFormatter {

    static let booksAPIDateFormater: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

}
