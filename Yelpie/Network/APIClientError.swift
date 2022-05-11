//
//  APIClientError.swift
//  Yelpie
//
//  Created by KhuongPham on 11/05/2022.
//

import Moya
import Alamofire

/// `APIClient`'s error
enum APIClientError: Error, LocalizedError {
    case noInternet
    case objectMapping
    case timedOut
    case tokenExpired
    case message(String)

    /// `FailureReason`, used to display as header
    var failureReason: String? {
        switch self {
        case .noInternet, .timedOut: return "Connection Error"
        default: return "Error"
        }
    }

    /// `ErrorDescription`, used to display as content
    var errorDescription: String? {
        switch self {
        case .noInternet: return "A network error has occurred. Please check your connection and try again."
        case .objectMapping: return "Failed to map JSON."
        case .timedOut: return "The request timed out."
        case .tokenExpired: return "The access token has expired."
        case .message(let message): return message
        }
    }
}

/// `MoyaError` extensions
extension MoyaError {
    /// Converted to APIClientError
    /// Note: currently we only support to display the error for no network explicitly
    var asAPIClientError: APIClientError {
        switch self {
        case let .underlying(error as AFError, _):
            switch error {
                /// No internet error
            case .sessionTaskFailed(error: let error as NSError) where error.code == NSURLErrorNotConnectedToInternet:
                return .noInternet

                /// Treat this as .noInternet also, since this can only happen when preceding request failed
            case .sessionTaskFailed(error: let error as NSError) where error.code == NSURLErrorResourceUnavailable:
                return .noInternet

            case .sessionTaskFailed(error: let error as NSError) where error.code == NSURLErrorTimedOut:
                return .timedOut

            default:
                return .message(error.localizedDescription)
            }

        case .objectMapping:
            return .objectMapping

        default:
            return .message(localizedDescription)
        }
    }
}

/// `Error` extensions
extension Error {
    /// Converted to APIClientError
    var asAPIClientError: APIClientError {
        switch self {
        case let self as MoyaError:
            return self.asAPIClientError

        default:
            return APIClientError.noInternet
        }
    }
}
