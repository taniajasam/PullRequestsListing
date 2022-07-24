//
//  HomeAPIConfiguration.swift
//  PRListing
//
//  Created by Tania Jasam on 24/07/22.
//

import Foundation

struct HomeAPIConfiguration: RequestConfiguration {
    func getURL() -> URL? {
        URL(string: "https://api.github.com/repos/taniajasam/PullRequestsListing/pulls")
    }
    
    func getHeaders() -> [String : String] {
        ["Accept": "application/vnd.github+json"]
    }
    
    func getRequestBody() -> [String : Any]? {
        ["state": "closed"]
    }
}
