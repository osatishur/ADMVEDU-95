//
//  DetailPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 27.04.2021.
//

import AVFoundation
import AVKit
import Foundation

protocol DetailPresenterProtocol: AnyObject {
    func loadView() -> UIView
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

    func loadView() -> UIView {
        UIView()
    }

    func getURL(urlString: String) -> URL? {
        if urlString.hasPrefix("http") {
            let url = URL(string: urlString)
            return url
        } else {
            let url = URL(string: urlString)
            let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            let destinationUrl = documentsDirectoryURL?.appendingPathComponent(url?.lastPathComponent ?? "")
            return destinationUrl
        }
    }
}
