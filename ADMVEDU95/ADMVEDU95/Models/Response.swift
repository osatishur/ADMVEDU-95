//
//  API_Responce.swift
//  FirstWorkProject
//
//  Created by Satsishur on 12.04.2021.
//

import Foundation

struct Response: Codable {
    let resultCount: Int
    let results: [ApiResult]
}




