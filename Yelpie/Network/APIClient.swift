//
//  APIClient.swift
//  Yelpie
//
//  Created by KhuongPham on 11/05/2022.
//

import Moya
import Alamofire
import RxSwift
import NSObject_Rx
import SVProgressHUD

/// `APIClient`, use this for network calls.
final class APIClient: NSObject {
    private let provider: MoyaProvider<API>

    init(provider: MoyaProvider<API> = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Session.default.sessionConfiguration.httpAdditionalHeaders
        configuration.timeoutIntervalForRequest = 20
        if #available(iOS 13.0, *) {
            configuration.requestCachePolicy = .reloadRevalidatingCacheData
        } else {
            configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
            configuration.urlCache = nil
        }
        let session = Alamofire.Session(configuration: configuration)
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        return MoyaProvider(session: session, plugins: [networkLogger])
    }()) {
        self.provider = provider
    }

    /**
     Request data from server then cast it as a Decodable type.
     - Parameter API: endpoint
     - Parameter type: Decodable type
     */
    func request<Object: Decodable>(_ API: API, for type: Object.Type) -> Single<Object> {
        _request(API, for: type, provider: provider)
    }

    /**
     Request data from server then cast it as a Decodable type.
     - Parameter API: endpoint
     - Parameter type: Decodable type
     - Parameter provider: the network provider, which will be switched to cache if there is connection issue
     */
    private func _request<Object: Decodable>(_ API: API, for type: Object.Type, provider: MoyaProvider<API>) -> Single<Object> {
        return Single.create { [weak self] single in
            let token = provider.request(API) { result in
                SVProgressHUD.dismiss()
                switch result {
                case let .success(response):
                    switch response.statusCode {
                    case 200:
                        do {
                            let object = try response.map(Object.self, atKeyPath: API.keyPath)
                            single(.success(object))
                        } catch let error {
                            print("API Error:", API, "\nfor type:", type, "\nreason:", error)
                            single(.error(error.asAPIClientError))
                        }
                    default:
                        single(.error(APIClientError.message("Unknown error with status code \(response.statusCode)")))
                    }
                case let .failure(error):
                    single(.error(error.asAPIClientError))
                }
            }

            return Disposables.create {
                token.cancel()
            }
        }
    }

    /**
     Request completable success or fail
     - Parameter API: endpoint
     */
    func request(_ API: API) -> Completable {
        return Completable.create { [weak self] completable in
            let cancellabel = self?.provider.request(API) { result in
                SVProgressHUD.dismiss()
                switch result {
                case let .success(response):
                    switch response.statusCode {
                    case 200:
                        completable(.completed)
                    default:
                        completable(.error(APIClientError.message("Unknown error with status code \(response.statusCode)")))
                    }
                case let .failure(error):
                    completable(.error(error.asAPIClientError))
                }
            }
            return Disposables.create {
                cancellabel?.cancel()
            }
        }
    }
}
