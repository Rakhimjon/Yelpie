//
//  FilterViewModel.swift
//  Yelpie
//
//  Created by KhuongPham on 12/05/2022.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation
import MapKit

final class FilterViewModel: NSObject {
    private weak var viewController: FilterViewController?

    let locations = BehaviorRelay<[Location]>(value: [])
    var selectedCuisine: String?

    func searchLocation(by name: String) {
        let request = MKLocalSearch.Request()
        let locationManager = MockLocationManager()
        guard let coordinate = locationManager.location?.coordinate else {
            return
        }

        request.naturalLanguageQuery = name
        request.region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)

        MKLocalSearch(request: request).start { response, error in
            guard error == nil, let response = response, response.mapItems.count > 0 else {
                return
            }
            let locations = response.mapItems.map {
                Location(
                    name: $0.name ?? "",
                    coordinate: $0.placemark.coordinate
                )
            }
            self.locations.accept(locations)
        }
    }
}
