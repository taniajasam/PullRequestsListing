//
//  Utilities.swift
//  PRListing
//
//  Created by Tania Jasam on 24/07/22.
//

import Foundation

class Utility {
    static func convertDateFromString(stringDate: String) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date: Date = dateFormatter.date(from: stringDate) {
            dateFormatter.dateFormat = "dd MMM yy, HH:mm"
            return dateFormatter.string(from: date)
        }
        return ""
    }
}
