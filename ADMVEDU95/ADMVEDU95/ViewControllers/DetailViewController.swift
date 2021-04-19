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
    private struct Localizable {
        static func localise(key: String, argument: String?) -> String {
            let noInfoString = NSLocalizedString("no info", comment: "")
            let str = String(format: NSLocalizedString(key, comment: ""), argument ?? noInfoString)
            return str
        }
    }
    //MARK: Views
    lazy var songView = AudioDetailView()
    lazy var movieView = VideoDetailView()
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
        songView.songNameLabel.text = Localizable.localise(key: "Song", argument: model.trackName)
        songView.artistNameLabel.text = Localizable.localise(key: "Artist", argument: model.artistName)
        songView.albumNameLabel.text = Localizable.localise(key: "Album", argument: model.collectionName)
        songView.albumImageView.loadImage(url: url)
        initAudioPlayer(songUrl: model.previewUrl)
        songView.playPauseButton.addTarget(self, action: #selector(playMusic), for: .touchUpInside)
    }
    
    private func configureVideoView(model: ApiResult, url: URL) {
        movieView.albumImageView.loadImage(url: url)
        movieView.directorNameLabel.text = Localizable.localise(key: "Director", argument: model.artistName)
        movieView.movieNameLabel.text = Localizable.localise(key: "Movie", argument: model.trackName)
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
