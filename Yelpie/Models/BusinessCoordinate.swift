//
//  BusinessCoordinate.swift
//  Yelpie
//
//  Created by KhuongPham on 12/05/2022.
//

import Foundation
import Codextended

struct BusinessCoordinate: Decodable {
    let latitude: Double
    let longitude: Double

    init(from decoder: Decoder) throws {
        latitude = try decoder.decodeIfPresent("latitude") ?? 0
        longitude = try decoder.decodeIfPresent("longitude") ?? 0
    }
}
