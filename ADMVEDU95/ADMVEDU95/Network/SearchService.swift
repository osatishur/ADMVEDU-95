//
//  SearchService.swift
//  ADMVEDU95
//
//  Created by Satsishur on 15.04.2021.
//

import Foundation

class SearchService {
    let networkManager = NetworkService()
    func searchResults(searchTerm: String,
                       completion: @escaping (Result<iTunesResponse, iTunesSearchError>)-> Void) {
        networkManager.getResults(endpoint: .search,
                                  parameters: ["term": searchTerm]) { (result: Result<iTunesResponse, iTunesSearchError>) in
            completion(result)
        }
    }
}
