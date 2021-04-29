//
//  DetailPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 27.04.2021.
//

import Foundation
import AVFoundation
import AVKit

protocol DetailViewProtocol: class {
    func setButtonImage(isPlayed: Bool)
    func configureView(model: ApiResult)
}

protocol DetailViewPresenterProtocol: class {
    init(view: DetailViewProtocol, dataKind: ResponseDataKind, model: ApiResult, router: HomeRouterProtocol)
    var dataKind: ResponseDataKind { get set }
    var playerViewController: AVPlayerViewController { get set }
    var player: AVPlayer? { get set }
    var playerItem: AVPlayerItem? { get set }
    func playVideo()
    func playMusic()
    func initAudioPlayer(songUrl: String?)
    func initVideoPlayer(movieUrl: String?)
    func navigateToHome()
}

class DetailPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    var router: HomeRouterProtocol?
    var dataKind: ResponseDataKind = .song
    var model: ApiResult?
    var playerViewController = AVPlayerViewController()
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    
    required init(view: DetailViewProtocol, dataKind: ResponseDataKind, model: ApiResult, router: HomeRouterProtocol) {
        self.view = view
        self.dataKind = dataKind
        self.model = model
        self.router = router
    }
    
    func initAudioPlayer(songUrl: String?) {
        guard let songUrl = songUrl,
              let url = URL(string: songUrl) else {
            return
        }
        let playerItem:AVPlayerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
    }
    
    func initVideoPlayer(movieUrl: String?) {
        guard let movieUrl = movieUrl,
              let url = URL(string: movieUrl) else {
            return
        }
        player = AVPlayer(url: url)
        playerViewController.player = player
    }
    
    func playMusic() {
        if self.player?.rate == 0 {
            self.player?.play()
            self.view?.setButtonImage(isPlayed: true)
        } else {
            self.player?.pause()
            self.view?.setButtonImage(isPlayed: false)
        }
    }
    
    func playVideo() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            let view = self.view as? DetailViewController
            view?.present(self.playerViewController, animated: true) {
                self.player?.play()
            }
        }
    }
    
    func navigateToHome() {
        router?.popToHome()
    }
}
