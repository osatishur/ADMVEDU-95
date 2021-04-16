//
//  SongDetailView.swift
//  FirstWorkProject
//
//  Created by Satsishur on 13.04.2021.
//

import UIKit

class SongDetailView: UIView {
    
    struct Constants {
        static let albumImageSize =  UIScreen.main.bounds.width * 0.7
        static let buttonSize: CGFloat = 70
        static let labelHeight: CGFloat = 22
        static let smallInterval: CGFloat = 20
        static let bigInterval: CGFloat = 30
        static let sideInterval: CGFloat = 8
    }
    
    let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var songNameLabel: UILabel = {
        let label = createLabel(numberOfLines: 0, textAlighment: .center)
        return label
    }()
    
    lazy var artistNameLabel: UILabel = {
        let label = createLabel(numberOfLines: 0, textAlighment: .center)
        return label
    }()
    
    lazy var albumNameLabel: UILabel = {
        let label = createLabel(numberOfLines: 0, textAlighment: .center)
        return label
    }()
    var playPauseButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }

    private func setupLayout() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(albumImageView)
        addSubview(songNameLabel)
        addSubview(artistNameLabel)
        addSubview(albumNameLabel)
        addSubview(playPauseButton)
    }
    
    private func setupConstraints() {
        setupAlbumImage()
        setupArtistName()
        setupSongName()
        setupAlbumName()
        setupplayPauseButton()
    }
    
    private func setupAlbumImage() {
        albumImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.smallInterval).isActive = true
        albumImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        albumImageView.widthAnchor.constraint(equalToConstant: Constants.albumImageSize).isActive = true
        albumImageView.heightAnchor.constraint(equalToConstant: Constants.albumImageSize).isActive = true
    }
    
    private func setupArtistName() {
        artistNameLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: Constants.bigInterval).isActive = true
        artistNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constants.sideInterval).isActive = true
        artistNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constants.sideInterval).isActive = true
        artistNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    private func setupSongName() {
        songNameLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: Constants.smallInterval).isActive = true
        songNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constants.sideInterval).isActive = true
        songNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constants.sideInterval).isActive = true
        songNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    private func setupAlbumName() {
        albumNameLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: Constants.smallInterval).isActive = true
        albumNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constants.sideInterval).isActive = true
        albumNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constants.sideInterval).isActive = true
        albumNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    private func setupplayPauseButton() {
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        playPauseButton.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: Constants.bigInterval).isActive = true
        playPauseButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize).isActive = true
        playPauseButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize).isActive = true
        playPauseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        playPauseButton.setBackgroundImage(UIImageView.playButtonImage, for: .normal)
    }
    
    private func createLabel(numberOfLines: Int, textAlighment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = numberOfLines
        label.textAlignment = textAlighment
        return label
    }
}
