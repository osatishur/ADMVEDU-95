//
//  SongDetailView.swift
//  FirstWorkProject
//
//  Created by Satsishur on 13.04.2021.
//

import UIKit

class AudioDetailView: XibView {
    @IBOutlet private weak var albumImageView: UIImageView!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var songNameLabel: UILabel!
    @IBOutlet private weak var albumNameLabel: UILabel!
    @IBOutlet private weak var playPauseButton: UIButton!
    
    var playMusic: (() -> ())?
    
    func configureView(albumImageURL: URL, artistName: String, songName: String, albumName: String, buttonAction: @escaping () -> ()) {
        albumImageView.loadImage(url: albumImageURL)
        artistNameLabel.text = artistName
        songNameLabel.text = songName
        albumNameLabel.text = albumName
        playMusic = buttonAction
        playPauseButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setPauseImage() {
        playPauseButton.setBackgroundImage(UIImageView.pauseButtonImage, for: UIControl.State.normal)
    }
    
    func setPlayImage() {
        playPauseButton.setBackgroundImage(UIImageView.playButtonImage, for: UIControl.State.normal)
    }
    
    @objc func buttonTapped() {
        playMusic?()
    }
}
