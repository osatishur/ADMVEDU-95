//
//  iTunesResult.swift
//  ADMVEDU95
//
//  Created by Satsishur on 14.04.2021.
//

import Foundation

struct ApiResult: Codable {
    let wrapperType: String?
    let kind: String?
    let artistName: String?
    let trackName: String?
    let collectionName: String?
    let artistViewUrl: String?
    let collectionViewUrl: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let country: String?
    let previewUrl: String?
}
