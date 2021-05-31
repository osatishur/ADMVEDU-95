//
//  NetworkService.swift
//  FirstWorkProject
//
//  Created by Satsishur on 12.04.2021.
//

import Alamofire
import Foundation

public enum NetworkError: Error {
    case emptyData
    case parsingData
    case unknown
    case networkLoss
}

class NetworkService {
    private enum NetworkConstants {
        static let baseUrl = "https://itunes.apple.com/"
    }

    enum Endpoint: String {
        case search = "search?"
    }

    static var shared = NetworkService()

    private init() {}

    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    public func get<T: Codable>(endpoint: Endpoint,
                                parameters: [String: String],
                                completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = buildURL(endpoint: endpoint) else {
            return
        }
//        guard let url = URL(string: "https://itunes.apple.com/search?term=jack+johnson&limit=25") else {
//            return
//        }
        print(url, parameters)
        AF.request(url, parameters: parameters).responseJSON { response in
            if response.error?.isSessionTaskError != nil {
                DispatchQueue.main.async {
                    let searchError: Result<T, NetworkError> = .failure(NetworkError.networkLoss)
                    completion(searchError)
                }
            }
            let result = self.parseResponse(data: response.data,
                                            response: response.response,
                                            error: response.error,
                                            type: T.self)
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    private func buildURL(endpoint: Endpoint) -> URL? {
        let path = NetworkConstants.baseUrl + endpoint.rawValue
        let urlComponents = URLComponents(string: path)
        guard let url = urlComponents?.url else {
            return nil
        }
        return url
    }

    private func parseResponse<T: Codable>(data: Data?,
                                           response _: URLResponse?,
                                           error: Error?, type: T.Type) -> Result<T, NetworkError> {
        guard let jsonData = data else {
            return .failure(NetworkError.emptyData)
        }

        if error != nil {
            return .failure(NetworkError.unknown)
        }

        do {
            let searchResponse = try decoder.decode(type, from: jsonData)
            return .success(searchResponse)
        } catch {
            print(error)
            return .failure(NetworkError.parsingData)
        }
    }
}
