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
    
    static func getFeed() -> DataRequest {
        var params = getBaseParams()
        params[Params.Method] = FlickrMethod.GetRecent
        params[Params.Extras] = ParamsValues.Extras
        
        return AF.request(API.FlickrURL, parameters: params)
    }
    
    static func search(_ query: String) -> DataRequest {
        var params = getBaseParams()
        params[Params.Method] = FlickrMethod.Search
        params[Params.Extras] = ParamsValues.Extras
        params[Params.Text] = query
        
        return AF.request(API.FlickrURL, parameters: params)
    }
    
    private static func getBaseParams() -> [String:String] {
        return [
            Params.Format : ParamsValues.Json,
            Params.NoJsonCallback : ParamsValues.One,
            Params.ApiKey : API.FlickrKey
        ]
    }
}
