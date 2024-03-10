//
//  NetworkingManager.swift
//  appStroeSearch
//
//  Created by siyeon park on 2023/05/26.
//

import Foundation
import Moya
/**
final class NetworkingManager {

    static let shared = NetworkingManager()

    private init() {}

    func searchApps(term: String, callback: (() -> ())?) {
        //https://itunes.apple.com/search?term=BTS&country=KR&media=music
        let host = "itunes.apple.com"
        let path = "search"
        let url = "https://\(host)/\(path)"

        let urlComponents = URLComponents(string: url)

        let params: Parameters = [
            "term": term,
            "country": "KR",
            "media": "software"
        ]

        guard let url = urlComponents?.url else { return }

        AF.request(url,
                   method: .get,
                   parameters: params
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: SearchResult.self) { response in
            switch response.result {
            case .success(let data):
                /** 요청에 성공한 경우 */
                guard response.data != nil else { return }
                print(data)
            case .failure(let error):
                print(error)
                /** 요청에 실패한 경우 */
            }
        }
    }

    /**
    static var dataRequest: DataRequest?

    static var itunesURLComponents: URLComponents {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "itunes.apple.com"
        return urlComponent
    }

    static func searchApps(term: String, completionHandler: @escaping (Result<SearchResult, Error>) -> Void) {
        var urlComponents = itunesURLComponents
        urlComponents.path = "/search"
        urlComponents.queryItems = [
            URLQueryItem(name: "entity", value: "software"),
            URLQueryItem(name: "term", value: term)
        ]

        guard let url = urlComponents.url else { return }
        print("url: \(url.description)")

        dataRequest = AF.request(url, method: .get)

        dataRequest?.responseData { response in
            switch response.result {
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(SearchResult.self, from: value)
                    completionHandler(.success(result))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }*/
}
*/
struct APIManager {

    let provider = MoyaProvider<ITunesAPI>()

//    func itunesAPI(term: String, completionHandler: @escaping(SearchResult)->(), failure: @escaping(Error)->()) {
//        provider.request(.search(term: term)) { result in
//            switch result {
//            case let .success(response):
//                do {
//                    let data = try response.map(SearchResult.self)
//                    completionHandler(data)
//                } catch {
//                    failure(error)
//                }
//            case let .failure(error):
//                failure(error)
//            }
//        }
//    }

    func itunesAPI(term: String,
                   completionHandler: @escaping (SearchModel) -> Void,
                   failure: @escaping (Error) -> Void) {
        provider.request(.search(term: term)) { result in
            switch result {
            case let .success(response):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(SearchModel.self, from: response.data)
                    completionHandler(response)
                } catch {
                    // completionHandler()
                    failure(error)
                }
            case let .failure(error):
                failure(error)
            }
        }
    }
}
