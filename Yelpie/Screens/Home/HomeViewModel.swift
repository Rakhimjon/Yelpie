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
import RxRelay

final class HomeViewModel: NSObject {
    private weak var viewController: HomeViewController?
    private let apiClient = APIClient()

    let businesses = BehaviorRelay<[Business]>(value: [])
    var filteredBusinesses: [Business] = []

    func fetchBusinesses(_ term: String? = nil, coordinate: CLLocationCoordinate2D? = nil) {
        var _coordinate: CLLocationCoordinate2D
        if let coordinate = coordinate {
            _coordinate = coordinate
        } else if let myLocation = MockLocationManager().location {
            _coordinate = myLocation.coordinate
        } else {
            return
        }
        apiClient.request(.searchBusinesses(term: term, coordinate: _coordinate), for: [Business].self)
            .subscribe(onSuccess: { [weak self] businesses in
                guard let self = self else {
                    return
                }
                self.filteredBusinesses = businesses
                self.businesses.accept(businesses)
            })
            .disposed(by: rx.disposeBag)
        }
}
