//
//  DetailVC.swift
//  FirstWorkProject
//
//  Created by Satsishur on 12.04.2021.
//

import AVFoundation
import AVKit
import UIKit

protocol DetailViewProtocol: AnyObject {}

class DetailViewController: UIViewController, DetailViewProtocol {
    var presenter: DetailPresenterProtocol?

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override func loadView() {
        if let presenter = presenter as? AudioPresenter {
            view = presenter.getAudioView()
        } else if let presenter = presenter as? VideoPresenter {
            view = presenter.getVideoView()
        }
    }
}
