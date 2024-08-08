//
//  User.swift
//  RadioApp
//
//  Created by Елена Логинова on 08.08.2024.
//

import Foundation

struct User: Decodable {
    let id: String
    var name: String = ""
    var email: String = ""
    var image: String?
}
