//
//  Location.swift
//  Yelpie
//
//  Created by KhuongPham on 12/05/2022.
//

import Foundation
import CoreLocation

struct Location {
    var name: String
    var coordinate: CLLocationCoordinate2D

    init(name: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.coordinate = coordinate
    }
}
