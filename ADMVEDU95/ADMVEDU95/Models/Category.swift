//
//  iTunesCategory.swift
//  ADMVEDU95
//
//  Created by Satsishur on 16.04.2021.
//

import Foundation

enum Category: String, CaseIterable {
    case all
    case music
    case movie
    case podcast
    case tvShow
    case ebook
    case audiobook
    case musicVideo
    case noInfo
}

extension Category {
    var kind: String {
        switch self {
        case .all:
            return R.string.localizable.categoryAllText()
        case .music:
            return R.string.localizable.categoryMusicText()
        case .movie:
            return R.string.localizable.categoryMovieText()
        case .podcast:
            return R.string.localizable.categoryPodcastText()
        case .tvShow:
            return R.string.localizable.categoryTvShowText()
        case .ebook:
            return R.string.localizable.categoryEbookText()
        case .audiobook:
            return R.string.localizable.categoryAudiobookText()
        case .musicVideo:
            return R.string.localizable.categoryMusicVideoText()
        case .noInfo:
            return R.string.localizable.noInfo()
        }
    }
}
