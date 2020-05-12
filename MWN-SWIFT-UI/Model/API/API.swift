//
//  API.swift
//  MWN - Minimal World News
//
//  Created by Lucas Menezes on 1/20/20.
//  Copyright © 2020 Lucas Menezes. All rights reserved.
//

import Foundation
import Alamofire

class API {
    let baseUrl = "https://trends.gab.com/trend-feed/json"
    func getNews(completion : @escaping (GabFeed?)->()) {
        let url = baseUrl
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let res):
                if let gabfeed = GabFeed(JSON: ((res as? [String : Any])!)){
                    //print(gabfeed.toJSONString(prettyPrint: true))
                    print(gabfeed.items?.first?.toJSONString() ?? "")
                        completion(gabfeed)
                    } else {
                        completion(nil)
                    }
            case .failure(_):
                completion(nil)
            }
        }
    }
    
}
