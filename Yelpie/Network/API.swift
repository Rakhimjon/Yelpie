//
//  API.swift
//  Yelpie
//
//  Created by KhuongPham on 11/05/2022.
//

import Moya
import CoreLocation

func loadJSON(fileName: String) -> Data? {
    guard
        let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
        let data = try? Data(contentsOf: url) else {
        return nil
    }

    return data
}

enum API {
    case searchBusinesses(term: String? = nil, coordinate: CLLocationCoordinate2D)
}

extension API: SugarTargetType {
    /// `Base URL`.
    var baseURL: URL {
        return Config.shared.baseURL
    }

    /// `Route`, this is a combination of `Path` & `Method`
    var route: Route {
        switch self {
        case .searchBusinesses:
            return .get("businesses/search")
        }
    }

    /// `Task`, put additional params here.
    var task: Task {
        switch self {
        case .searchBusinesses(let term, let coordinate):
            var params: [String: Any] = [
                "latitude": coordinate.latitude,
                "longitude": coordinate.longitude
            ]
            if let term = term {
                params["term"] = term
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }

    /// `Headers`, put additional headers here.
    var headers: [String: String]? {
        return [
            "authorization": "Bearer \(Config.shared.apiKey)",
            "content-type": "application/json"
        ]
    }

    /// `Sample data`, put sample data here.
    var sampleData: Data {
        switch self {
        case .searchBusinesses:
            return loadJSON(fileName: "businesses") ?? Data()
        }
    }
}

// MARK: KeyPath
/// For nested values when decoding data
extension API {
    var keyPath: String? {
        switch self {
        case .searchBusinesses:
            return "businesses"
        }
    }
}
