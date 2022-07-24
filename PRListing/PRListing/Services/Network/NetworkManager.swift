//
//  NetworkManager.swift
//  PRListing
//
//  Created by Tania Jasam on 24/07/22.
//

import Foundation
import Combine

protocol NetworkRequestable {
    func dataTask<T: Decodable>(with requestConfig: RequestConfiguration, type: T.Type) -> Future<T, Error>
}




