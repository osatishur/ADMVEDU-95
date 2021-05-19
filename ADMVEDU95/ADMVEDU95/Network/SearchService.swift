//
//  SearchService.swift
//  ADMVEDU95
//
//  Created by Satsishur on 15.04.2021.
//

import Foundation

protocol SearchServiceProtocol {
    func searchResults(searchTerm: String,
                       filter: String,
                       completion: @escaping (Result<Response, NetworkError>)-> Void)
}

class SearchService: SearchServiceProtocol {
    private struct Constants {
        static let searchParameter = "term"
        static let limitParameter = "limit"
        static let searchLimit = "5"
        static let filterParameter = "media"
    }
    
    func searchResults(searchTerm: String,
                       filter: String,
                       completion: @escaping (Result<Response, NetworkError>)-> Void) {
        NetworkService.shared.get(endpoint: .search,
                                  parameters: [Constants.searchParameter: searchTerm,
                                               Constants.limitParameter: Constants.searchLimit,
                                               Constants.filterParameter: filter],
                                  completion: completion)
    }
}
