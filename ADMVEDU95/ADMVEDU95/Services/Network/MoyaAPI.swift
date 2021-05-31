//
//  MoyaAPI.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 28.05.2021.
//

import Moya

enum MoyaAPI {
    case search(url: URL, parameters: [String: String])
}

extension MoyaAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .search(let url, _):
            return url
        }
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
        case .search(_, let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return nil
    }
}
