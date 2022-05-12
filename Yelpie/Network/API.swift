//
//  API.swift
//  Yelpie
//
//  Created by KhuongPham on 11/05/2022.
//

import Moya

enum API {
    case searchBusinesses(term: String? = nil, latitude: Double, longitude: Double)
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
        case .searchBusinesses(let term, let latitude, let longitude):
            var params: [String: Any] = [
                "latitude": latitude,
                "longitude": longitude
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
        Data()
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
