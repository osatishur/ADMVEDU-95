//
//  VideoPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 04.05.2021.
//

import AVKit
import Foundation

class VideoPresenter: DetailPresenter {
    private enum Constants {
        static let width = UIScreen.main.bounds.width
        static let height = UIScreen.main.bounds.height
    }

    var playerViewController = AVPlayerViewController()
    var player: AVPlayer?

    private let videoView = VideoDetailView(frame: CGRect(x: .zero, y: .zero, width: Constants.width, height: Constants.height))

    override func loadView() -> UIView {
        let view = getVideoView()
        return view
    }

    private func getVideoView() -> VideoDetailView {
        guard let imageURL = model?.artworkUrl100,
              let url = URL(string: imageURL)
        else {
            return VideoDetailView()
        }
        configureVideoView(view: videoView, url: url)
        initVideoPlayer(movieUrl: model?.previewUrl)
        return videoView
    }

    private func configureVideoView(view: VideoDetailView, url: URL) {
        let noInfo = R.string.localizable.noInfo()
        view.configureView(albumImageURL: url,
                           directorName: String(format: R.string.localizable.detailDirectorName(model?.artistName ?? noInfo)),
                           movieName: String(format: R.string.localizable.detailMovieName(model?.trackName ?? noInfo)))
        view.configureAction(buttonAction: playVideo)
    }

    private func initVideoPlayer(movieUrl: String?) {
        guard let urlString = movieUrl,
              let url = getURL(urlString: urlString)
        else {
            return
        }
        player = AVPlayer(url: url)
        playerViewController.player = player
    }

    private func playVideo() {
        let view = view as? DetailViewController
        view?.present(playerViewController, animated: true) {
            self.player?.play()
        }
    }
}
