//
//  DetailViewModel.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 02.06.2021.
//

import Foundation
import AVFoundation
import AVKit

protocol DetailViewModelProtocol: AnyObject {
    var model: ApiResult? { get set }
    func loadView() -> UIView
}

class DetailViewModel: DetailViewModelProtocol {
    private var router: HomeRouterProtocol?
    var model: ApiResult?

    init(model: ApiResult, router: HomeRouterProtocol) {
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
