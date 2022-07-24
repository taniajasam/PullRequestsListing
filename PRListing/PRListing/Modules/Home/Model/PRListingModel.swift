//
//  PRListingModel.swift
//  PRListing
//
//  Created by Tania Jasam on 24/07/22.
//

import Foundation

struct PRListingModel: Decodable {
    let url: String?
    let id: Int?
    let state: String?
    let title: String?
    let user: PROwner?
    let body: String?
    let created_at: String?
    let updated_at: String?
    let closed_at: String?
    let merged_at: String?
}

struct PROwner: Decodable {
    let login: String?
    let avatar_url: String?
}
