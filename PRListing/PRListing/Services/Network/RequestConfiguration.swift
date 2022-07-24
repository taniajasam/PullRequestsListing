//
//  RequestConfiguration.swift
//  PRListing
//
//  Created by Tania Jasam on 24/07/22.
//

import Foundation

enum HTTPRequestMethod: String {
    case GET, POST, PUT, DELETE
}

protocol RequestConfiguration {
    
    func getURL() -> URL?
    
    func getMethod() -> HTTPRequestMethod
    
    func getHeaders() -> [String: String]
}

extension RequestConfiguration {
    
    func getMethod() -> HTTPRequestMethod {
        return .GET
    }
    
    func getHeaders() -> [String: String] {
        return [:]
    }
}
