//
//  ResponseDataKind.swift
//  ADMVEDU95
//
//  Created by Satsishur on 16.04.2021.
//

import Foundation

enum ResponseDataKind: String {
    case song
    case movie = "feature-movie"
    case podcast
    case tvShow
    case ebook
    case audiobook
    case musicVideo = "music-video"
    case noInfo = "no info"
}

extension ResponseDataKind {
    var kind: String {
        switch self {
        case .song:
            return R.string.localizable.dataKindSongText()
        case .movie:
            return R.string.localizable.dataKindFeatureMovieText()
        case .podcast:
            return R.string.localizable.dataKindPodcastText()
        case .tvShow:
            return R.string.localizable.dataKindTvShowText()
        case .ebook:
            return R.string.localizable.dataKindEbookText()
        case .audiobook:
            return R.string.localizable.dataKindAudiobookText()
        case .musicVideo:
            return R.string.localizable.dataKindMusicVideoText()
        case .noInfo:
            return R.string.localizable.noInfo()
        }
    }
}
