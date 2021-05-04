//
//  MovieDetail.swift
//  FirstWorkProject
//
//  Created by Satsishur on 13.04.2021.
//

import UIKit

class VideoDetailView: XibView {
    @IBOutlet private weak var albumImageView: UIImageView!
    @IBOutlet private weak var directorNameLabel: UILabel!
    @IBOutlet private weak var movieNameLabel: UILabel!
    
    private var playVideoHandler: (() -> ())?
    
    func configureView(albumImageURL: URL, directorName: String, movieName: String, buttonAction: @escaping () -> ()) {
        albumImageView.loadImage(url: albumImageURL)
        directorNameLabel.text = directorName
        movieNameLabel.text = movieName
        playVideoHandler = buttonAction
        addGestureToImage()
    }
    
    func addGestureToImage() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        albumImageView.isUserInteractionEnabled = true
        albumImageView.addGestureRecognizer(tap)
    }
    
    @objc private func imageTapped() {
        playVideoHandler?()
    }
}
