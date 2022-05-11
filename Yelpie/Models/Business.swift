//
//  Business.swift
//  Yelpie
//
//  Created by KhuongPham on 11/05/2022.
//

import Foundation
import Codextended

struct Business: Decodable {
    let id: String
    let name: String

    init(from decoder: Decoder) throws {
        id = try decoder.decodeIfPresent("id") ?? ""
        name = try decoder.decodeIfPresent("name") ?? ""
    }
}
