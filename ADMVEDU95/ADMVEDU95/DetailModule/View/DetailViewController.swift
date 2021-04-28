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
    
    var presenter: DetailViewPresenterProtocol!
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func loadView() {
        super.loadView()
        if presenter.dataKind == .song {
            view = songView
        } else {
            view = movieView
        }
    }
}

extension DetailViewController {
    func configureView(model: ApiResult) {
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
        songView.playPauseButton.addTarget(self, action: #selector(playMusic), for: .touchUpInside)
        
        presenter.initAudioPlayer(songUrl: model.previewUrl)
    }
    
    private func configureVideoView(model: ApiResult, url: URL) {
        movieView.albumImageView.loadImage(url: url)
        movieView.directorNameLabel.text = String(format: "Director".localized(), model.artistName ?? "no info".localized())
        movieView.movieNameLabel.text = String(format: "Movie".localized(), model.trackName ?? "no info".localized())
        
        presenter.initVideoPlayer(movieUrl: model.previewUrl)

        let tap = UITapGestureRecognizer(target: self, action: #selector(playVideo))
        movieView.albumImageView.isUserInteractionEnabled = true
        movieView.albumImageView.addGestureRecognizer(tap)
    }
    
    @objc private func playMusic() {
        presenter.playMusic()
    }
    
    @objc private func playVideo() {
        presenter.playVideo()
    }
}

extension DetailViewController: DetailViewProtocol {
    func setButtonImage(isPlayed: Bool) {
        if isPlayed {
            songView.playPauseButton.setBackgroundImage(UIImageView.pauseButtonImage, for: UIControl.State.normal)
        } else {
            songView.playPauseButton.setBackgroundImage(UIImageView.playButtonImage, for: UIControl.State.normal)
        }
    }
}
