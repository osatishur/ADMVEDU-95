//
//  NetworkService.swift
//  FirstWorkProject
//
//  Created by Satsishur on 12.04.2021.
//

import Alamofire
import Foundation
import Moya

public enum NetworkError: Error {
    case emptyData
    case parsingData
    case unknown
    case networkLoss
}

enum NetworkConstants {
    static let baseUrl = "https://itunes.apple.com"
}

enum Endpoint: String {
    case search = "/search"
}

class NetworkService {
    static var shared = NetworkService()

    private init() {}

    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    var provider = MoyaProvider<MoyaAPI>()

    public func get<T: Codable>(endpoint: Endpoint,
                                parameters: [String: String],
                                completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = buildURL(endpoint: endpoint) else {
            return
        }
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
        
//        provider.request(MoyaAPI.search(query: parameters)) { result in
//            switch result {
//            case .success(let response):
//                do {
//                    let results = try self.decoder.decode(T.self, from: response.data)
//                    print(result)
//                    completion(.success(results))
//                } catch _ {
//                    print("FAILURE1")
//                    completion(.failure(NetworkError.unknown))
//                }
//            case .failure(_):
//                print("FAILURE2")
//                completion(.failure(NetworkError.unknown))
//            }
//        }
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
            return .failure(NetworkError.parsingData)
        }
    }
}
