//
//  MoyaAPI.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 28.05.2021.
//

import Moya

enum MoyaAPI {
    case search(query: [String: String])
}

extension MoyaAPI: TargetType {
    var baseURL: URL {
        let urlString = NetworkConstants.baseUrl
        guard let url = URL(string: urlString) else { fatalError() }
        return url
    }

    var path: String {
        switch self {
        case .search:
            return Endpoint.search.rawValue
        }
    }

    var method: Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .search(let query):
            return .requestParameters(parameters: query, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return nil
    }
}
