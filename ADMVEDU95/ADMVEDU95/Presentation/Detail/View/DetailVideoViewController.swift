//
//  DetailVideoViewController.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 15.06.2021.
//

import UIKit

class DetailVideoViewController: UIViewController, DetailViewProtocol {    
    @IBOutlet private weak var imageVIew: UIImageView!
    @IBOutlet private weak var directorNameLabel: UILabel!
    @IBOutlet private weak var movieNameLabel: UILabel!

    var viewModel: VideoViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.initVideoPlayer()
        viewModel?.configureView(view: self)
        addGestureToImage()
    }

    func configureView(albumImageURL: URL, directorName: String, movieName: String) {
        imageVIew.loadImage(url: albumImageURL)
        directorNameLabel.text = directorName
        movieNameLabel.text = movieName
    }

    func addGestureToImage() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageVIew.isUserInteractionEnabled = true
        imageVIew.addGestureRecognizer(tap)
    }

    @objc
    private func imageTapped() {
        viewModel?.playVideo(view: self)
    }
}
