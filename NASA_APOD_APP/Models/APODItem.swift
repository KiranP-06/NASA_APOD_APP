//
//  APODItem.swift
//  NASA_APOD_APP
//
//  Created by admin34 on 30/12/25.
//

import Foundation

struct APODItem: Codable, Identifiable {
    var id: String { date } 
    let copyright: String?
    let date: String
    let explanation: String
    let hdurl: String?
    let mediaType: String
    let serviceVersion: String
    let title: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}
