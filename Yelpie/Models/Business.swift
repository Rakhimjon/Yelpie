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
    let imageURLString: String
    let categories: [BusinessCategory]
    let coordinate: BusinessCoordinate?
    let location: BusinessLocation?
    let rating: Double
    let reviewCount: Int
    let price: String

    init(from decoder: Decoder) throws {
        id = try decoder.decodeIfPresent("id") ?? ""
        name = try decoder.decodeIfPresent("name") ?? ""
        imageURLString = try decoder.decodeIfPresent("image_url") ?? ""
        categories = try decoder.decodeIfPresent("categories") ?? []
        coordinate = try decoder.decodeIfPresent("coordinates")
        location = try decoder.decodeIfPresent("location")
        rating = try decoder.decodeIfPresent("rating") ?? 0
        reviewCount = try decoder.decodeIfPresent("review_count") ?? 0
        price = try decoder.decodeIfPresent("price") ?? ""
    }
}
