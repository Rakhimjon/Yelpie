//
//  HomeViewModel.swift
//  Yelpie
//
//  Created by KhuongPham on 11/05/2022.
//

import Foundation
import RxSwift
import CoreLocation

final class HomeViewModel: NSObject {
    private weak var viewController: HomeViewController?

    var businesses: [Business] = []
    var filteredBusinesses: [Business] = []

    func fetchBusinesses(_ term: String? = nil, latitude: Double? = nil, longitude: Double? = nil) -> Single<[Business]> {
        var lat: Double = 0
        var long: Double = 0
        if let latitude = latitude, let longitude = longitude {
            lat = latitude
            long = longitude
        } else if let myLocation = MockLocationManager().location {
            let coordiate = myLocation.coordinate
            lat = coordiate.latitude
            long = coordiate.longitude
        } else {
            return .just([])
        }
        return APIClient.shared.request(.searchBusinesses(term: term, latitude: lat, longitude: long), for: [Business].self)
            .do(onSuccess: { [weak self] businesses in
                guard let self = self else {
                    return
                }
                self.businesses = businesses
                self.filteredBusinesses = businesses
            })
        }
}
