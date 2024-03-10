//
//  String+Extension.swift
//  appStroeSearch
//
//  Created by siyeon park on 2023/04/24.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", comment: "")
    }
}
