//
//  AudioPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 04.05.2021.
//

import AVKit
import Foundation

class AudioPresenter: DetailPresenter {
    private enum Constants {
        static let width = UIScreen.main.bounds.width
        static let height = UIScreen.main.bounds.height
    }

    private let songView = AudioDetailView(frame: CGRect(x: .zero, y: .zero, width: Constants.width, height: Constants.height))

    override func loadView() -> UIView {
        let view = getAudioView()
        return view
    }

    private func getAudioView() -> AudioDetailView {
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
        let noInfoString = R.string.localizable.noInfo()
        view.configureView(albumImageURL: url,
                           artistName: String(format: R.string.localizable.artist(model?.artistName ?? noInfoString)),
                           songName: String(format: R.string.localizable._Song(model?.trackName ?? noInfoString)),
                           albumName: String(format: R.string.localizable.album(model?.collectionName ?? noInfoString)))
        view.configureAction(buttonAction: playMusic)
    }

    private func initAudioPlayer(songUrl: String?) {
        guard let urlString = songUrl,
              let url = getURL(urlString: urlString)
        else {
            return
        }
        let playerItem: AVPlayerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
    }

    private func playMusic() {
        if player?.rate == .zero {
            player?.play()
            songView.setPauseImage()
        } else {
            player?.pause()
            songView.setPlayImage()
        }
    }
}
