//
//  HomeViewModel.swift
//  Yelpie
//
//  Created by KhuongPham on 11/05/2022.
//

import Foundation
import RxSwift

final class HomeViewModel: NSObject {
    private weak var viewController: HomeViewController?

    var businesses: [Business] = []

    func fetchBusinesses() -> Single<[Business]> {
        APIClient.shared.request(.searchBusinesses(term: "restaurant"), for: [Business].self)
            .do(onSuccess: { [weak self] businesses in
                self?.businesses = businesses
            })
        }
}
