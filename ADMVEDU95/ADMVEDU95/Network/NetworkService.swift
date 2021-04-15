//
//  NetworkService.swift
//  FirstWorkProject
//
//  Created by Satsishur on 12.04.2021.
//

import Foundation

public enum iTunesSearchError: Error {
    case emptyData
    case parsingData(Error?)
    case unknown(Error?)
}

public enum Endpoint {
    case search
    
    var endpoint: String {
        switch self {
        case .search:
            return "/search?"
        }
    }
}

class NetworkService {
    struct Constants {
        static let baseUrl = "https://itunes.apple.com"
    }
    
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    public func getResults<T: Codable>(endpoint: Endpoint,
                                       parameters: [String: String],
                                       completion: @escaping (Result<T, iTunesSearchError>) -> Void) {
        let url = buildURL(endpoint: endpoint, parameters: parameters)
        print(url)
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let result = self.parseResponse(data: data,
                                            response: response,
                                            error: error, type: T.self)
            DispatchQueue.main.async {
                completion(result)
            }
        }
        task.resume()
    }

    private func buildURL(endpoint: Endpoint, parameters: [String : String]) -> URL {
        let path = Constants.baseUrl + endpoint.endpoint
        var urlComponents = URLComponents(string: path)
        for (key, value) in parameters {
            let item = URLQueryItem(name: key, value: value)
            urlComponents?.queryItems?.append(item)
        }
        
        guard let url = urlComponents?.url else {
            fatalError("Error: expected iTunes URL but instead it is nil")
        }
        return url
    }
    
    private func parseResponse<T: Codable>(data: Data?,
                                           response _: URLResponse?,
                                           error: Error?, type: T.Type) -> Result<T, iTunesSearchError> {
        guard let jsonData = data else {
            return .failure(iTunesSearchError.emptyData)
        }

        if let error = error {
            return .failure(iTunesSearchError.unknown(error))
        }

        do {
            let searchResponse = try decoder.decode(type, from: jsonData)
            return .success(searchResponse)
        } catch let jsonError {
            return .failure(iTunesSearchError.parsingData(jsonError))
        }
    }
}
