//
//  SearchResult.swift
//  appStroeSearch
//
//  Created by siyeon park on 2023/04/24.
//

import Foundation

// MARK: - SearchResult
struct SearchResult: Decodable {
    let resultCount: Int
    let results: [SearchItemResult]
}

// MARK: - SearchItemResult
struct SearchItemResult: Decodable {
    let screenshotUrls, ipadScreenshotUrls: [String]
    let artworkUrl60, artworkUrl512, artworkUrl100: String
    let artistViewURL: String
    let features: [String]
    let supportedDevices, advisories: [String]
    let isGameCenterEnabled: Bool
    let kind: String
    let minimumOSVersion, trackCensoredName: String
    let languageCodesISO2A: [String]
    let fileSizeBytes: String
    let sellerURL: String?
    let formattedPrice: String?
    let contentAdvisoryRating: String
    let averageUserRatingForCurrentVersion: Double
    let userRatingCountForCurrentVersion: Int
    let averageUserRating: Double
    let trackViewURL: String
    let trackContentRating: String
    let bundleID: String
    let trackID: Int
    let trackName: String
    let primaryGenreName: String
    let genreIDS: [String]
    let isVppDeviceBasedLicensingEnabled: Bool
    let sellerName: String
    let releaseNotes: String?
    let primaryGenreID: Int
    let currency: String
    let version: String
    let wrapperType: String
    let artistID: Int
    let artistName: String
    let genres: [String]
    let price: Double?
    let resultDescription: String
    let userRatingCount: Int

    enum CodingKeys: String, CodingKey {
        case screenshotUrls, ipadScreenshotUrls, artworkUrl60, artworkUrl512, artworkUrl100
        case artistViewURL = "artistViewUrl"
        case features, supportedDevices, advisories, isGameCenterEnabled, kind
        case minimumOSVersion = "minimumOsVersion"
        case trackCensoredName, languageCodesISO2A, fileSizeBytes
        case sellerURL = "sellerUrl"
        case formattedPrice, contentAdvisoryRating, averageUserRatingForCurrentVersion, userRatingCountForCurrentVersion, averageUserRating
        case trackViewURL = "trackViewUrl"
        case trackContentRating
        case bundleID = "bundleId"
        case trackID = "trackId"
        case trackName, primaryGenreName
        case genreIDS = "genreIds"
        case isVppDeviceBasedLicensingEnabled, sellerName, releaseNotes
        case primaryGenreID = "primaryGenreId"
        case currency, version, wrapperType
        case artistID = "artistId"
        case artistName, genres, price
        case resultDescription = "description"
        case userRatingCount
    }
}
