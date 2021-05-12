//
//  VideoPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 04.05.2021.
//

import AVKit
import Foundation

protocol VideoPresenterProtocol: DetailPresenterProtocol {
    func getVideoView() -> VideoDetailView
    func playVideo()
    func initVideoPlayer(movieUrl: String?)
}

class VideoPresenter: DetailPresenter, VideoPresenterProtocol {
    enum Constants {
        static let width = UIScreen.main.bounds.width
        static let height = UIScreen.main.bounds.height
    }

    let videoView = VideoDetailView(frame: CGRect(x: .zero, y: .zero, width: Constants.width, height: Constants.height))

    func getVideoView() -> VideoDetailView {
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
        view.configureView(albumImageURL: url,
                           directorName: String(format: "Director".localized(), model?.artistName ?? "no info".localized()),
                           movieName: String(format: "Movie".localized(), model?.trackName ?? "no info".localized()),
                           buttonAction: playVideo)
    }

    func initVideoPlayer(movieUrl: String?) {
        guard let movieUrl = movieUrl,
              let url = URL(string: movieUrl)
        else {
            return
        }
        player = AVPlayer(url: url)
        playerViewController.player = player
    }

    func playVideo() {
        let view = view as? DetailViewController
        view?.present(playerViewController, animated: true) {
            self.player?.play()
        }
    }
}
