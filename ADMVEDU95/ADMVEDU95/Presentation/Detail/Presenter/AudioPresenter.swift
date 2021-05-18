//
//  AudioPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 04.05.2021.
//

import Foundation
import AVKit

class AudioPresenter: DetailPresenter {
    let songView = AudioDetailView(frame: CGRect(x: .zero, y: .zero, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    override func loadView() -> UIView {
        let view = getAudioView()
        return view
    }
    
    func getAudioView() -> AudioDetailView {
        guard let imageURL = model?.artworkUrl100,
              let url = URL(string: imageURL) else {
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
        guard let urlString = songUrl,
              let url = getURL(urlString: urlString) else {
            return
        }
        let playerItem: AVPlayerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
    }
    
    func playMusic() {
        if self.player?.rate == .zero {
            self.player?.play()
            self.songView.setPauseImage()
        } else {
            self.player?.pause()
            self.songView.setPlayImage()
        }
    }
}
