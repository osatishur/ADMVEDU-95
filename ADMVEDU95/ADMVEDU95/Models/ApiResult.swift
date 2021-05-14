//
//  iTunesResult.swift
//  ADMVEDU95
//
//  Created by Satsishur on 14.04.2021.
//

import Foundation

import Foundation

struct ApiResult: Codable {
    let kind: String?
    let artistName: String?
    let trackName: String?
    let collectionName: String?
    let artworkUrl100: String?
    let previewUrl: String?
}

extension ApiResult {
    var isInsufficient: Bool {
        return (kind == nil || artistName == nil || trackName == nil)
    }
}
