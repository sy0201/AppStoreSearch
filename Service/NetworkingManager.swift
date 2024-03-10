//
//  NetworkingManager.swift
//  appStroeSearch
//
//  Created by siyeon park on 2023/05/26.
//

import Foundation
import Moya

final class NetworkingManager {
    static let shared = NetworkingManager()

    private init() {}

    let provider = MoyaProvider<ItunesAPI>()

    func searchItunesAPI(term: String,
                         completionHandler: @escaping([SearchItemResult]) -> Void,
                         failure: @escaping(Error) -> Void) {
        provider.request(.search(term: term)) { result in
            switch result {
            case let .success(response):

                do {
                    let data = try response.map(SearchResult.self)
                    completionHandler(data.results)
                } catch {
                    failure(error)
                }

            case let .failure(error):
                failure(error)
            }
        }
    }
}
