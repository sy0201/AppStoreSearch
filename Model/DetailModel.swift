//
//  DetailModel.swift
//  appStoreSearch
//
//  Created by siyeon park on 2023/08/08.
//

import Foundation

struct DetailModel {
    var data: SearchItemResult

    var title: String = ""
    var img: String = ""
    var description: String = ""
    var screenShotImage: [String] = []

    init(_ model: SearchItemResult) {
        self.data = model
        self.title = data.trackName
        self.img = data.artworkUrl100
        self.description = data.resultDescription
        self.screenShotImage = data.screenshotUrls
    }
}
