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
    
    func getRequestBody() -> [String: Any]?
}

extension RequestConfiguration {
    
    func getMethod() -> HTTPRequestMethod {
         .GET
    }
    
    func getHeaders() -> [String: String] {
         [:]
    }
    
    func getRequestBody() -> [String: Any]? {
         nil
    }
}
