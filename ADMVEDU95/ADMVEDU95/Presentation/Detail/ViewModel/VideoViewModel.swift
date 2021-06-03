//
//  VideoViewModel.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 02.06.2021.
//

import AVKit
import Foundation

class VideoViewModel: DetailViewModel {
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

    func getVideoView() -> VideoDetailView {
        guard let imageURL = model?.artworkUrl100,
              let url = URL(string: imageURL)
        else {
            return VideoDetailView()
        }
        initVideoPlayer(movieUrl: model?.previewUrl)
        configureVideoView(view: videoView, url: url)
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

    func playVideo() {
        //let view = view as? DetailViewController
//        print(2222222)
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = videoView.bounds
//        videoView.layer.addSublayer(playerLayer)
//        player?.play()
//        view?.present(playerViewController, animated: true) {
//            self.player?.play()
//        }
    }
}
