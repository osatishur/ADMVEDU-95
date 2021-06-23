//
//  VideoViewModel.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 02.06.2021.
//

import AVKit
import Foundation

class VideoViewModel: DetailViewModel {
    var playerViewController = AVPlayerViewController()
    var player: AVPlayer?

    func configureView(view: DetailVideoViewController) {
        guard let imageURL = model?.artworkUrl100,
              let url = URL(string: imageURL) else {
            return
        }
        let noInfoString = R.string.localizable.noInfo()
        view.configureView(albumImageURL: url,
                           directorName: String(format: R.string.localizable.detailDirectorName(model?.artistName ?? noInfoString)),
                           movieName: String(format: R.string.localizable.detailMovieName(model?.trackName ?? noInfoString)))
    }

    func initVideoPlayer() {
        guard let urlString = model?.previewUrl,
              let url = getURL(urlString: urlString)
        else {
            return
        }
        player = AVPlayer(url: url)
        playerViewController.player = player
    }

    func playVideo(view: DetailVideoViewController) {
        view.present(playerViewController, animated: true) {
            self.player?.play()
        }
    }
}
