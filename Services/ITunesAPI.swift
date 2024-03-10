//
//  ITunesAPI.swift
//  appStoreSearch
//
//  Created by Gyuchan Jeon on 2023/06/03.
//

import Moya

enum ITunesAPI {
    case search(term: String)
}

extension ITunesAPI: TargetType {
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
            return .requestParameters(parameters: ["term": term, "media": "software"], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        nil
    }
}
