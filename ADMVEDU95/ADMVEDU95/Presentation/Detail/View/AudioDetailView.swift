//
//  SongDetailView.swift
//  FirstWorkProject
//
//  Created by Satsishur on 13.04.2021.
//

import UIKit

class AudioDetailView: XibView {
    @IBOutlet private var albumImageView: UIImageView!
    @IBOutlet private var artistNameLabel: UILabel!
    @IBOutlet private var songNameLabel: UILabel!
    @IBOutlet private var albumNameLabel: UILabel!
    @IBOutlet private var playPauseButton: UIButton!

    private var playMusicHandler: (() -> Void)?
    //var viewModel: AudioViewModel?

    func configureView(albumImageURL: URL, artistName: String, songName: String, albumName: String) {
        albumImageView.loadImage(url: albumImageURL)
        artistNameLabel.text = artistName
        songNameLabel.text = songName
        albumNameLabel.text = albumName
    }

    func configureAction(buttonAction: @escaping () -> Void) {
        playMusicHandler = buttonAction
        playPauseButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    func setPauseImage() {
        playPauseButton.setBackgroundImage(UIImageView.pauseButtonImage, for: .normal)
    }

    func setPlayImage() {
        playPauseButton.setBackgroundImage(UIImageView.playButtonImage, for: .normal)
    }

    @objc
    private func buttonTapped() {
        playMusicHandler?()
    }
}
