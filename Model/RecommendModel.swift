//
//  RecommendModel.swift
//  appStoreSearch
//
//  Created by siyeon park on 2023/07/19.
//

import Foundation

struct RecommendModel {
    var dataList = [RecommendData]()

    class RecommendData {
        var image: String? = ""
        var title: String? = ""
        var description: String? = ""

        init(image: String = "", title: String, description: String) {
            self.image = image
            self.title = title
            self.description = description
        }
    }
}
