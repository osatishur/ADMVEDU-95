//
//  DetailAudioViewController.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 15.06.2021.
//

import UIKit

class DetailAudioViewController: UIViewController, DetailViewProtocol {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var songNameLabel: UILabel!
    @IBOutlet private weak var albumNameLabel: UILabel!
    @IBOutlet private weak var playerButton: UIButton!

    var viewModel: AudioViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.initAudioPlayer()
        viewModel?.configureView(view: self)
        self.viewModel?.isPlayImageSet.bind({ [weak self] value in
            self?.setPlayPauseImage(value: value ?? false)
        })
    }

    @IBAction func playerButtonTapped(_ sender: Any) {
        viewModel?.playMusic()
    }

    func setPlayPauseImage(value: Bool) {
        if value {
            playerButton.setBackgroundImage(UIImageView.playButtonImage, for: .normal)
        } else {
            playerButton.setBackgroundImage(UIImageView.pauseButtonImage, for: .normal)
        }
    }

    func configureView(albumImageURL: URL, songName: String, artistName: String, albumName: String) {
        imageView.loadImage(url: albumImageURL)
        artistNameLabel.text = artistName
        songNameLabel.text = songName
        albumNameLabel.text = albumName
    }
}
