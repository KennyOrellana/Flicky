//
//  API.swift
//  Flicky
//
//  Created by Kenny Orellana on 9/16/20.
//  Copyright © 2020 Kenny Orellana. All rights reserved.
//

import Foundation

struct API {
    static let FlickrURL = "https://www.flickr.com/services/rest"
    static let FlickrKey = "23394b99783521a3601c218a9f514a44"
}

struct Params {
    static let Format = "format"
    static let NoJsonCallback = "nojsoncallback"
    static let Method = "method"
    static let ApiKey = "api_key"
    static let Extras = "extras"
}

struct ParamsValues {
    static let Json = "json"
    static let One = "1"
    static let Extras = "date_upload,owner_name,url_z,url_k"
}

struct FlickrMethod {
    static let GetRecent = "flickr.photos.getRecent"
}
