//
//  DetailPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 27.04.2021.
//

import Foundation
import AVFoundation
import AVKit

protocol DetailPresenterProtocol: AnyObject {
    var playerViewController: AVPlayerViewController { get set }
    var player: AVPlayer? { get set }
    var playerItem: AVPlayerItem? { get set }
    func navigateToHome()
}

class DetailPresenter: DetailPresenterProtocol {
    weak var view: DetailViewProtocol?
    var router: HomeRouterProtocol?
    var model: ApiResult?
    var playerViewController = AVPlayerViewController()
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    
    init(view: DetailViewProtocol, model: ApiResult, router: HomeRouterProtocol) {
        self.view = view
        self.model = model
        self.router = router
    }
    
    func navigateToHome() {
        router?.popToHome()
    }
}
