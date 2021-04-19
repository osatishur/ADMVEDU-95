//
//  MovieDetail.swift
//  FirstWorkProject
//
//  Created by Satsishur on 13.04.2021.
//

import UIKit

class VideoDetailView: UIView {
    struct Constants {
        static let albumImageSize =  UIScreen.main.bounds.width * 0.7
        static let labelHeight: CGFloat = 22
        static let smallInterval: CGFloat = 20
        static let bigInterval: CGFloat = 30
        static let sideInterval: CGFloat = 8
    }
    
    var albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var movieNameLabel: UILabel = {
        let label = createLabel(numberOfLines: 0, textAlighment: .center)
        return label
    }()
    
    lazy var directorNameLabel: UILabel = {
        let label = createLabel(numberOfLines: 0, textAlighment: .center)
        return label
    }()
    
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
        addSubview(directorNameLabel)
        addSubview(movieNameLabel)
    }
    
    private func setupConstraints() {
        setupAlbumImage()
        setupAuthorName()
        setupMovieName()
    }
    
    private func setupAlbumImage() {
        albumImageView.anchor(top: self.safeAreaLayoutGuide.topAnchor,
                              paddingTop: Constants.smallInterval)
        albumImageView.centerAnchor(centerX: self.centerXAnchor)
        albumImageView.dimension(width: Constants.albumImageSize,
                                 height: Constants.albumImageSize)
    }
    
    private func setupAuthorName() {
        directorNameLabel.anchor(top: albumImageView.bottomAnchor,
                                 paddingTop: Constants.bigInterval,
                                 left: self.leftAnchor,
                                 paddingLeft: Constants.sideInterval,
                                 right: self.rightAnchor,
                                 paddingRight: Constants.sideInterval)
        directorNameLabel.centerAnchor(centerX: self.centerXAnchor)
    }
    
    private func setupMovieName() {
        movieNameLabel.anchor(top: directorNameLabel.bottomAnchor,
                              paddingTop: Constants.smallInterval,
                              left: self.leftAnchor,
                              paddingLeft: Constants.sideInterval,
                              right: self.rightAnchor,
                              paddingRight: Constants.sideInterval)
        movieNameLabel.centerAnchor(centerX: self.centerXAnchor)
    }
    
    private func createLabel(numberOfLines: Int, textAlighment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.numberOfLines = numberOfLines
        label.textAlignment = textAlighment
        return label
    }
}
