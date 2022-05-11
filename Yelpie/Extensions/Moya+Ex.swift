//
//  Moya+Ex.swift
//  Yelpie
//
//  Created by KhuongPham on 11/05/2022.
//

import Moya

/**
 `Route` helps make Moya more syntactic sugar.
 Inspired by: https://github.com/devxoul/MoyaSugar
 */
enum Route {
    case get(String)
    case post(String)
    case delete(String)
    case put(String)
    case patch(String)

    var path: String {
        switch self {
        case .get(let path): return path
        case .post(let path): return path
        case .delete(let path): return path
        case .put(let path): return path
        case .patch(let path): return path
        }
    }

    var method: Moya.Method {
        switch self {
        case .get: return .get
        case .post: return .post
        case .delete: return .delete
        case .put: return .put
        case .patch: return .patch
        }
    }
}

protocol SugarTargetType: TargetType {
    var route: Route { get }
}

extension SugarTargetType {
    var path: String { return route.path }
    var method: Moya.Method { return route.method }
}
