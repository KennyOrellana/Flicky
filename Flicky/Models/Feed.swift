//
//  Feed.swift
//  Flicky
//
//  Created by Kenny Orellana on 9/16/20.
//  Copyright © 2020 Kenny Orellana. All rights reserved.
//

import Foundation

class Feed: Codable {
    let photos: Photos
    let stat: String

    init(photos: Photos, stat: String) {
        self.photos = photos
        self.stat = stat
    }
}
