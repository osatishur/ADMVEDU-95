//
//  SongDetailView.swift
//  FirstWorkProject
//
//  Created by Satsishur on 13.04.2021.
//

import UIKit

class AudioDetailView: UIView {
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
        albumImageView.anchor(top: self.safeAreaLayoutGuide.topAnchor, paddingTop: Constants.smallInterval,
                              centerX: self.centerXAnchor,
                              width: Constants.albumImageSize,
                              height: Constants.albumImageSize)
    }
    
    private func setupArtistName() {
        artistNameLabel.anchor(top: albumImageView.bottomAnchor, paddingTop: Constants.bigInterval,
                               left: self.leftAnchor, paddingLeft: Constants.sideInterval,
                               right: self.rightAnchor, paddingRight: -Constants.sideInterval,
                               centerX: self.centerXAnchor,
                               width: 0,
                               height: 0)
    }
    
    private func setupSongName() {
        songNameLabel.anchor(top: artistNameLabel.bottomAnchor, paddingTop: Constants.smallInterval,
                               left: self.leftAnchor, paddingLeft: Constants.sideInterval,
                               right: self.rightAnchor, paddingRight: -Constants.sideInterval,
                               centerX: self.centerXAnchor,
                               width: 0,
                               height: 0)
    }
    
    private func setupAlbumName() {
        albumNameLabel.anchor(top: songNameLabel.bottomAnchor, paddingTop: Constants.smallInterval,
                               left: self.leftAnchor, paddingLeft: Constants.sideInterval,
                               right: self.rightAnchor, paddingRight: -Constants.sideInterval,
                               centerX: self.centerXAnchor,
                               width: 0,
                               height: 0)
    }
    
    private func setupplayPauseButton() {
        playPauseButton.setBackgroundImage(UIImageView.playButtonImage, for: .normal)
        playPauseButton.anchor(top: albumNameLabel.bottomAnchor, paddingTop: Constants.bigInterval,
                               centerX: self.centerXAnchor,
                               width: Constants.buttonSize,
                               height: Constants.buttonSize)
    }
    
    private func createLabel(numberOfLines: Int, textAlighment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = numberOfLines
        label.textAlignment = textAlighment
        return label
    }
}
