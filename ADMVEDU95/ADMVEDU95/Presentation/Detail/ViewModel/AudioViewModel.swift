//
//  AudioViewModel.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 02.06.2021.
//

import Foundation
import AVKit

class AudioViewModel: DetailViewModel {
    var isPlayImageSet: Observable<Bool> = Observable(value: true)
    var player: AVPlayer?

    func configureView(view: DetailAudioViewController) {
        guard let imageURL = model?.artworkUrl100,
              let url = URL(string: imageURL) else {
            return
        }
        let noInfoString = R.string.localizable.noInfo()
        view.configureView(albumImageURL: url,
                           songName: String(format: R.string.localizable.detailSongName(model?.trackName ?? noInfoString)),
                           artistName: String(format: R.string.localizable.detailArtistName(model?.artistName ?? noInfoString)),
                           albumName: String(format: R.string.localizable.detailAlbumName(model?.collectionName ?? noInfoString)))
    }

    func initAudioPlayer() {
        guard let urlString = model?.previewUrl,
              let url = getURL(urlString: urlString) else {
            return
        }
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
    }

    func playMusic() {
        if player?.rate == .zero {
            player?.play()
            setPauseImage()
        } else {
            player?.pause()
            setPlayImage()
        }
    }

    private func setPlayImage() {
        self.isPlayImageSet.value = true
    }

    private func setPauseImage() {
        self.isPlayImageSet.value = false
    }
}
