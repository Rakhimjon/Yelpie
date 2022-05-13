//
//  YelpieTests.swift
//  YelpieTests
//
//  Created by KhuongPham on 11/05/2022.
//

import XCTest
import Moya
import CoreLocation
@testable import Yelpie

class YelpieTests: XCTestCase {
    var apiClient: APIClient!

    override func setUp() {
        super.setUp()
        apiClient = APIClient(provider: MoyaProvider<API>(stubClosure: MoyaProvider.immediatelyStub))
    }

    func testFetchBusinesses() throws {
        let expectedBusinessesCount = 20
        apiClient.request(.searchBusinesses(term: nil, coordinate: MockLocationManager().location!.coordinate), for: [Business].self)
            .subscribe(onSuccess: { businesses in
                XCTAssertTrue(businesses.count == expectedBusinessesCount)
            })
            .disposed(by: rx.disposeBag)
    }
}
