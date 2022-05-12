//
//  MockLocationManager.swift
//  Yelpie
//
//  Created by KhuongPham on 12/05/2022.
//

import Foundation
import CoreLocation

protocol LocationManager{
    var location:CLLocation? {get}
}

extension CLLocationManager: LocationManager {}

class MockLocationManager:LocationManager{
    var location:CLLocation? = CLLocation(latitude: 41.232380, longitude: -99.818237)
}
