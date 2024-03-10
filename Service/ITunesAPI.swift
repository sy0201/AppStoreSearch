//
//  ITunesAPI.swift
//  appStoreSearch
//
//  Created by siyeon park on 2023/06/03.
//

import Moya

enum ItunesAPI {
    case search(term: String)
}

extension ItunesAPI: TargetType {
    var baseURL: URL {
        URL(string: "https://itunes.apple.com")!
    }

    var path: String {
        "search"
    }

    var method: Moya.Method {
        .get
    }

    var task: Task {
        switch self {
        case let .search(term):
            return .requestParameters(parameters: ["term": term, "country": "KR", "media": "software"], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        nil
    }
}
