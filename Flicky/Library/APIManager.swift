//
//  APIManager.swift
//  Flicky
//
//  Created by Kenny Orellana on 9/16/20.
//  Copyright © 2020 Kenny Orellana. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    static func getFeed(page: Int = 1) -> DataRequest {
        var params = getBaseParams(page: page)
        params[Params.Method] = FlickrMethod.GetRecent
        
        return AF.request(API.FlickrURL, parameters: params)
    }
    
    static func search(page: Int = 1, _ query: String) -> DataRequest {
        var params = getBaseParams(page: page)
        params[Params.Method] = FlickrMethod.Search
        params[Params.Text] = query
        
        return AF.request(API.FlickrURL, parameters: params)
    }
    
    private static func getBaseParams(page: Int = 1) -> [String:String] {
        return [
            Params.Format : ParamsValues.Json,
            Params.NoJsonCallback : ParamsValues.One,
            Params.ApiKey : API.FlickrKey,
            Params.Extras : ParamsValues.Extras,
            Params.Page : String(page)
        ]
    }
}
