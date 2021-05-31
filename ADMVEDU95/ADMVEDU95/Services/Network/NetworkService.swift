//
//  NetworkService.swift
//  FirstWorkProject
//
//  Created by Satsishur on 12.04.2021.
//

import Alamofire
import Foundation
import Moya

enum NetworkError: Error {
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

    private var provider = MoyaProvider<MoyaAPI>()

    public func get<T: Codable>(endpoint: Endpoint,
                                parameters: [String: String],
                                completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = buildURL(endpoint: endpoint) else {
            return
        }
        let networkFrameworkSelected = UserDefaults.getNetworkFramework()
        switch networkFrameworkSelected {
        case .alamofire:
            makeRequestWithAlamofire(url: url,
                                     parameters: parameters,
                                     type: T.self,
                                     completion: completion)
        case .moya:
            let moyaAPI: MoyaAPI
            switch endpoint {
            case .search:
                moyaAPI = MoyaAPI.search(url: url, parameters: parameters)
            }
            makeRequestWithMoya(moyaAPI: moyaAPI,
                                type: T.self,
                                completion: completion)
        }
    }

    private func makeRequestWithAlamofire<T: Codable>(url: URL,
                                                      parameters: [String: String],
                                                      type: T.Type,
                                                      completion: @escaping (Result<T, NetworkError>) -> Void) {
        AF.request(url, parameters: parameters).responseJSON { response in
            if response.error?.isSessionTaskError != nil {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.networkLoss))
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

    private func makeRequestWithMoya<T: Codable>(moyaAPI: MoyaAPI,
                                                 type: T.Type,
                                                 completion: @escaping (Result<T, NetworkError>) -> Void) {
        provider.request(moyaAPI) { result in
            switch result {
            case .success(let response):
                let result = self.parseResponse(data: response.data,
                                                response: nil,
                                                error: nil,
                                                type: T.self)
                completion(result)
            case .failure(let error):
                if error.asAFError?.isSessionTaskError != nil {
                    completion(.failure(NetworkError.networkLoss))
                }
                completion(.failure(NetworkError.unknown))
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
            return .failure(NetworkError.parsingData)
        }
    }
}
