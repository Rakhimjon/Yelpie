//
//  HomeViewModel.swift
//  Yelpie
//
//  Created by KhuongPham on 11/05/2022.
//

import Foundation
import RxSwift
import CoreLocation
import MapKit

final class HomeViewModel: NSObject {
    private weak var viewController: HomeViewController?

    var businesses: [Business] = []
    var filteredBusinesses: [Business] = []

    func fetchBusinesses(_ term: String? = nil, coordinate: CLLocationCoordinate2D? = nil) -> Single<[Business]> {
        var _coordinate: CLLocationCoordinate2D
        if let coordinate = coordinate {
            _coordinate = coordinate
        } else if let myLocation = MockLocationManager().location {
            _coordinate = myLocation.coordinate
        } else {
            return .just([])
        }
        return APIClient.shared.request(.searchBusinesses(term: term, coordinate: _coordinate), for: [Business].self)
            .do(onSuccess: { [weak self] businesses in
                guard let self = self else {
                    return
                }
                self.businesses = businesses
                self.filteredBusinesses = businesses
            })
        }
}
