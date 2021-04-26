//
//  DetailVC.swift
//  FirstWorkProject
//
//  Created by Satsishur on 12.04.2021.
//

import UIKit
import AVFoundation
import AVKit

class DetailViewController: UIViewController {
    //MARK: Views
    lazy var songView: AudioDetailView = {
        let view = AudioDetailView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        return view
    }()
    lazy var movieView: VideoDetailView = {
        let view = VideoDetailView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        return view
    }()
    //MARK: Properties
    let playerViewController = AVPlayerViewController()
    var player: AVPlayer?
    var playerItem:AVPlayerItem?
    var iTunesDataType: ResponseDataKind = .song
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func loadView() {
        super.loadView()
        if iTunesDataType == .song {
            view = songView
        } else {
            view = movieView
            print("movie")
        }
    }
    //MARK: Configure View
    public func configureView(model: ApiResult) {
        guard let imageURL = model.artworkUrl100,
              let url = URL(string: imageURL) else {
            return
        }
        if model.kind == ResponseDataKind.movie.rawValue {
            configureVideoView(model: model, url: url)
        } else {
            configureAudioView(model: model, url: url)
        }
    }
    
    private func configureAudioView(model: ApiResult, url: URL) {
        songView.songNameLabel.text = String(format: "Song".localized(), model.trackName ?? "no info".localized())
        songView.artistNameLabel.text = String(format: "Artist".localized(), model.artistName ?? "no info".localized())
        songView.albumNameLabel.text = String(format: "Album".localized(), model.collectionName ?? "no info".localized())
        songView.albumImageView.loadImage(url: url)
        initAudioPlayer(songUrl: model.previewUrl)
        songView.playPauseButton.addTarget(self, action: #selector(playMusic), for: .touchUpInside)
    }
    
    private func configureVideoView(model: ApiResult, url: URL) {
        movieView.albumImageView.loadImage(url: url)
        movieView.directorNameLabel.text = String(format: "Director".localized(), model.artistName ?? "no info".localized())
        movieView.movieNameLabel.text = String(format: "Movie".localized(), model.trackName ?? "no info".localized())
        initVideoPlayer(movieUrl: model.previewUrl)

        let tap = UITapGestureRecognizer(target: self, action: #selector(playVideo))
        movieView.albumImageView.isUserInteractionEnabled = true
        movieView.albumImageView.addGestureRecognizer(tap)
    }
    
    private func initAudioPlayer(songUrl: String?) {
        guard let songUrl = songUrl,
              let url = URL(string: songUrl)
        else {
            return
        }
        let playerItem:AVPlayerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
    }
    
    private func initVideoPlayer(movieUrl: String?) {
        guard let movieUrl = movieUrl,
              let url = URL(string: movieUrl)
        else {
            return
        }
        player = AVPlayer(url: url)
        playerViewController.player = player
    }

    @objc private func playMusic() {
        if self.player?.rate == 0 {
            self.player?.play()
            self.songView.playPauseButton.setBackgroundImage(UIImageView.pauseButtonImage, for: UIControl.State.normal)
        } else {
            self.player?.pause()
            self.songView.playPauseButton.setBackgroundImage(UIImageView.playButtonImage, for: UIControl.State.normal)
        }
    }
    
    @objc private func playVideo() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.present(self.playerViewController, animated: true) {
                self.player?.play()
            }
        }
    }
}
