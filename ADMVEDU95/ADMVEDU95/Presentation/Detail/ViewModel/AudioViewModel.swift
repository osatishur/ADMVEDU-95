//
//  AudioViewModel.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 02.06.2021.
//

import Foundation

import AVKit
import Foundation

class AudioViewModel: DetailViewModel {
    private enum Constants {
        static let width = UIScreen.main.bounds.width
        static let height = UIScreen.main.bounds.height
    }

    var player: AVPlayer?

    private let songView = AudioDetailView(frame: CGRect(x: .zero, y: .zero, width: Constants.width, height: Constants.height))

    override func loadView() -> UIView {
        let view = getAudioView()
        return view
    }

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
        let noInfoString = R.string.localizable.noInfo()
        view.configureView(albumImageURL: url,
                           artistName: String(format: R.string.localizable.detailArtistName(model?.artistName ?? noInfoString)),
                           songName: String(format: R.string.localizable.detailSongName(model?.trackName ?? noInfoString)),
                           albumName: String(format: R.string.localizable.detailAlbumName(model?.collectionName ?? noInfoString)))
        view.configureAction(buttonAction: playMusic)
    }

    private func initAudioPlayer(songUrl: String?) {
        guard let urlString = songUrl,
              let url = getURL(urlString: urlString)
        else {
            return
        }
        let playerItem = AVPlayerItem(url: url)
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
