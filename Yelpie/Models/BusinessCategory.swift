//
//  BusinessCategory.swift
//  Yelpie
//
//  Created by KhuongPham on 11/05/2022.
//

import Foundation
import Codextended

struct BusinessCategory: Decodable {
    let alias: String
    let title: String

    init(from decoder: Decoder) throws {
        alias = try decoder.decodeIfPresent("alias") ?? ""
        title = try decoder.decodeIfPresent("title") ?? ""
    }
}
