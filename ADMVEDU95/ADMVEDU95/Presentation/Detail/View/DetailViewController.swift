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
    
    var presenter: DetailViewPresenterProtocol?
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func loadView() {
        super.loadView()
        if presenter?.dataKind == .song {
            view = songView
        } else {
            view = movieView
        }
    }
}

extension DetailViewController: DetailViewProtocol {
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
        songView.configureView(albumImageURL: url,
                               artistName: String(format: "Artist".localized(), model.artistName ?? "no info".localized()),
                               songName: String(format: "Song".localized(), model.trackName ?? "no info".localized()),
                               albumName: String(format: "Album".localized(), model.collectionName ?? "no info".localized()),
                               buttonAction: playMusic)
        
        presenter?.initAudioPlayer(songUrl: model.previewUrl)
    }
    
    private func configureVideoView(model: ApiResult, url: URL) {
        movieView.configureView(albumImageURL: url,
                                directorName: String(format: "Director".localized(), model.artistName ?? "no info".localized()),
                                movieName: String(format: "Movie".localized(), model.trackName ?? "no info".localized()),
                                buttonAction: playVideo)
        
        presenter?.initVideoPlayer(movieUrl: model.previewUrl)
    }
    
    @objc private func playMusic() {
        presenter?.playMusic()
    }
    
    @objc private func playVideo() {
        presenter?.playVideo()
    }
    
    func setButtonImage(isPlayed: Bool) {
        if isPlayed {
            songView.setPauseImage()
        } else {
            songView.setPlayImage()
        }
    }
}
