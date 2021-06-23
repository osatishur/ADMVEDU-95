//
//  DetailViewModel.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 02.06.2021.
//

import UIKit

protocol DetailViewModelProtocol: AnyObject {
    var model: ApiResult? { get set }
}

class DetailViewModel: DetailViewModelProtocol {    
    private var router: HomeRouterProtocol?
    var model: ApiResult?

    init(model: ApiResult, router: HomeRouterProtocol) {
        self.model = model
        self.router = router
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
