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
        static let filterParameter = "media"
    }
    
    func searchResults(searchTerm: String,
                       filter: String,
                       completion: @escaping (Result<Response, iTunesSearchError>)-> Void) {
        NetworkService.shared.get(endpoint: .search,
                                  parameters: [Constants.searchParameter: searchTerm,
                                               Constants.filterParameter: filter],
                                  completion: completion)
    }
}
