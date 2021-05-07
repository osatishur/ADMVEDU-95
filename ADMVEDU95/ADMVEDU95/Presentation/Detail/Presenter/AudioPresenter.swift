//
//  AudioPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 04.05.2021.
//

import AVKit
import Foundation

protocol AudioPresenterProtocol: DetailPresenterProtocol {
    func getAudioView() -> AudioDetailView
    func playMusic()
    func initAudioPlayer(songUrl: String?)
}

class AudioPresenter: DetailPresenter, AudioPresenterProtocol {
    let songView = AudioDetailView(frame: CGRect(x: .zero, y: .zero, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))

    func getAudioView() -> AudioDetailView {
        guard let imageURL = model?.artworkUrl100,
              let url = URL(string: imageURL)
        else {
            return AudioDetailView()
        }
        configureAudioView(view: songView, url: url)
        initAudioPlayer(songUrl: model?.previewUrl)
        return songView
    }

    private func configureAudioView(view: AudioDetailView, url: URL) {
        view.configureView(albumImageURL: url,
                           artistName: String(format: "Artist".localized(), model?.artistName ?? "no info".localized()),
                           songName: String(format: "Song".localized(), model?.trackName ?? "no info".localized()),
                           albumName: String(format: "Album".localized(), model?.collectionName ?? "no info".localized()),
                           buttonAction: playMusic)
    }

    func initAudioPlayer(songUrl: String?) {
        guard let songUrl = songUrl,
              let url = URL(string: songUrl)
        else {
            return
        }
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
    }

    func playMusic() {
        if player?.rate == .zero {
            player?.play()
            songView.setPauseImage()
        } else {
            player?.pause()
            songView.setPlayImage()
        }
    }
}
