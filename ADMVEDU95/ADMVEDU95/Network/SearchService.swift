//
//  SearchService.swift
//  ADMVEDU95
//
//  Created by Satsishur on 15.04.2021.
//

import Foundation

class SearchService {
    private struct Constants {
        static let searchParameter = "term"
    }
    
    func searchResults(searchTerm: String,
                       completion: @escaping (Result<iTunesResponse, iTunesSearchError>)-> Void) {
        NetworkService.shared.get(endpoint: .search,
                                  parameters: [Constants.searchParameter: searchTerm],
                                  completion: completion)
    }
}
