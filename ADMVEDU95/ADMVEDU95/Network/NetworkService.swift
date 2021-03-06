//
//  NetworkService.swift
//  FirstWorkProject
//
//  Created by Satsishur on 12.04.2021.
//

import Foundation
import Alamofire

public enum iTunesSearchError: Error {
    case emptyData
    case parsingData(Error?)
    case unknown(Error?)
}

class NetworkService {
    struct NetworkConstants {
        static let baseUrl = "https://itunes.apple.com/"
        
        enum Endpoint: String {
            case search = "search?"
        }
    }
    
    static var shared: NetworkService = NetworkService()
    
    private init() {}
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    public func get<T: Codable>(endpoint: NetworkConstants.Endpoint,
                                       parameters: [String: String],
                                       completion: @escaping (Result<T, iTunesSearchError>) -> Void) {
        guard let url = buildURL(endpoint: endpoint, parameters: parameters) else {
            return
        }
        print(url)
        AF.request(url).responseJSON(completionHandler: { (response) in
            let result = self.parseResponse(data: response.data,
                                            response: response.response,
                                            error: response.error,
                                            type: T.self)
            DispatchQueue.main.async {
                completion(result)
            }
        })
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            let result = self.parseResponse(data: data,
//                                            response: response,
//                                            error: error, type: T.self)
//            DispatchQueue.main.async {
//                completion(result)
//            }
//        }
//        task.resume()
    }

    private func buildURL(endpoint: NetworkConstants.Endpoint,
                          parameters: [String : String]) -> URL? {
        let path = NetworkConstants.baseUrl + endpoint.rawValue
        var urlComponents = URLComponents(string: path)
        for (key, value) in parameters {
            let item = URLQueryItem(name: key, value: value)
            urlComponents?.queryItems?.append(item)
        }
       
        guard let url = urlComponents?.url else {
            //fatalError("Error: expected iTunes URL but instead it is nil")
            return nil
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
