//
//  SearchModel.swift
//  appStoreSearch
//
//  Created by siyeon park on 2023/06/12.
//
import Foundation
import UIKit

public class SearchModel: Codable {

    public var dataList = [SearchModel]()
    public var resultList = [SearchResultList]()

    public class SearchResultList: Codable {
        public var artworkURL: String = ""
        public var appTitle: String = ""
        public var artistName: String = ""

        enum CodingKeys: String, CodingKey {
            case artworkURL = "artworkUrl60"
            case appTitle = "trackName"
            case artistName
        }
    }
}
