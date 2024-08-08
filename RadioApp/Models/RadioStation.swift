//
//  RadioStation.swift
//  RadioApp
//
//  Created by Елена Логинова on 08.08.2024.
//

import Foundation

struct RadioStation: Decodable {
    let stationuuid: String
    let name: String
    let votes: Int
    let url_resolved: String
    let tags: String
    var isFavorite: Bool?
    
    var capitalizedName: String {
        let stroke = name.replacingOccurrences(of: "\t", with: "", options: NSString.CompareOptions.literal, range: nil)
        return stroke.capitalized
    }
    
    var tag: String {
        guard let stroke = tags.components(separatedBy: CharacterSet(charactersIn: " ,")).first else { return "" }
        return stroke.capitalized
    }
}
