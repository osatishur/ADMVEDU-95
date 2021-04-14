//
//  MovieDetail.swift
//  FirstWorkProject
//
//  Created by Satsishur on 13.04.2021.
//

import UIKit

class MovieDetailView: UIView {
    
    struct Constants {
        static let albumImageSize =  UIScreen.main.bounds.width * 0.7
        static let labelHeight: CGFloat = 22
        static let smallInterval: CGFloat = 20
        static let bigInterval: CGFloat = 30
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
    
    lazy var authorNameLabel: UILabel = {
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
        addSubview(authorNameLabel)
        addSubview(movieNameLabel)
    }
    
    private func setupConstraints() {
        setupAlbumImage()
        setupAuthorName()
        setupMovieName()
    }
    
    private func setupAlbumImage() {
        albumImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.smallInterval).isActive = true
        albumImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        albumImageView.widthAnchor.constraint(equalToConstant: Constants.albumImageSize).isActive = true
        albumImageView.heightAnchor.constraint(equalToConstant: Constants.albumImageSize).isActive = true
    }
    
    private func setupAuthorName() {
        authorNameLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: Constants.bigInterval).isActive = true
        authorNameLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight).isActive = true
        authorNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    private func setupMovieName() {
        movieNameLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: Constants.smallInterval).isActive = true
        movieNameLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight).isActive = true
        movieNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    private func createLabel(numberOfLines: Int, textAlighment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = numberOfLines
        label.textAlignment = textAlighment
        return label
    }
}
