//
//  Photo.swift
//  Flicky
//
//  Created by Kenny Orellana on 9/16/20.
//  Copyright © 2020 Kenny Orellana. All rights reserved.
//

import Foundation

class Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
    let dateupload, ownername: String
    let urlMedium: String?
    let heightZ, widthZ: Int?
    let urlLarge: String?
    let heightK, widthK: Int?

    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title, ispublic, isfriend, isfamily, dateupload, ownername
        case urlMedium = "url_z"
        case heightZ = "height_z"
        case widthZ = "width_z"
        case urlLarge = "url_k"
        case heightK = "height_k"
        case widthK = "width_k"
    }

    init(id: String, owner: String, secret: String, server: String, farm: Int, title: String, ispublic: Int, isfriend: Int, isfamily: Int, dateupload: String, ownername: String, urlMedium: String?, heightZ: Int?, widthZ: Int?, urlLarge: String?, heightK: Int?, widthK: Int?) {
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.farm = farm
        self.title = title
        self.ispublic = ispublic
        self.isfriend = isfriend
        self.isfamily = isfamily
        self.dateupload = dateupload
        self.ownername = ownername
        self.urlMedium = urlMedium
        self.heightZ = heightZ
        self.widthZ = widthZ
        self.urlLarge = urlLarge
        self.heightK = heightK
        self.widthK = widthK
    }
    
    func getDateFormated() -> String {
        if let date = Double(dateupload) {
            return date.getDateStringFromUTC()
        } else {
            return ""
        }
    }
}
