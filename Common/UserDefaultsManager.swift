//
//  UserDefaultsManager.swift
//  appStoreSearch
//
//  Created by siyeon park on 2023/06/10.
//

import Foundation

enum UserDefaultKeys: String {
    case recentSearchTerms = "historyQuerys"
}

struct UserDefaultsManager {
    static func updateStringArray(value: [String], key: UserDefaultKeys) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }

    static func getStringArray(key: UserDefaultKeys) -> [String] {
        UserDefaults.standard.stringArray(forKey: key.rawValue) ?? []
    }
}
