//
//  BusinessLocation.swift
//  Yelpie
//
//  Created by KhuongPham on 11/05/2022.
//

import Foundation
import Codextended

struct BusinessLocation: Decodable {
    let city: String
    let country: String
    let address1: String
    let address2: String
    let address3: String
    let state: String
    let zipCode: String
    let displayAddress: [String]

    init(from decoder: Decoder) throws {
        city = try decoder.decodeIfPresent("city") ?? ""
        country = try decoder.decodeIfPresent("country") ?? ""
        address1 = try decoder.decodeIfPresent("address1") ?? ""
        address2 = try decoder.decodeIfPresent("address2") ?? ""
        address3 = try decoder.decodeIfPresent("address3") ?? ""
        state = try decoder.decodeIfPresent("state") ?? ""
        zipCode = try decoder.decodeIfPresent("zip_code") ?? ""
        displayAddress = try decoder.decodeIfPresent("display_address") ?? []
    }
}
